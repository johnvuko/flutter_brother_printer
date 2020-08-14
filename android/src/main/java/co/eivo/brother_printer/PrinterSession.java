package co.eivo.brother_printer;

import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.util.Log;

import com.brother.ptouch.sdk.CustomPaperInfo;
import com.brother.ptouch.sdk.LabelInfo;
import com.brother.ptouch.sdk.Printer;
import com.brother.ptouch.sdk.PrinterInfo;
import com.brother.ptouch.sdk.PrinterStatus;
import com.brother.ptouch.sdk.Unit;

import java.util.List;
import java.util.Map;

interface BRPrinterSessionCompletion {
    public void completion(Exception exception);
}

class PrinterErrorException extends Exception {
    public PrinterInfo.ErrorCode code;

    PrinterErrorException(PrinterInfo.ErrorCode code) {
        super(code.toString());
        this.code = code;
    }
}

public class PrinterSession {

    void print(Context context, int modelCode, final String path, String ipAddress, String macAddress, String bleAdvertiseLocalName, final BRPrinterSessionCompletion completion) {
        PrinterInfo.Model model = PrinterInfo.Model.valueFromID(modelCode);

        final Printer printer = new Printer();
        final PrinterInfo settings = printer.getPrinterInfo();
        settings.printerModel = model;
        settings.workPath = context.getFilesDir().getAbsolutePath();
        settings.isAutoCut = true;
        settings.printMode = PrinterInfo.PrintMode.FIT_TO_PAGE;

        if (ipAddress != null) {
            settings.port = PrinterInfo.Port.NET;
            settings.ipAddress = ipAddress;
        } else if (macAddress != null) {
            printer.setBluetooth(BluetoothAdapter.getDefaultAdapter());
            settings.port = PrinterInfo.Port.BLUETOOTH;
            settings.macAddress = macAddress;
        } else if (bleAdvertiseLocalName != null) {
            settings.port = PrinterInfo.Port.BLE;
            settings.setLocalName(bleAdvertiseLocalName);
        }

        if (model == PrinterInfo.Model.TD_2120N) {
            settings.paperSize = PrinterInfo.PaperSize.CUSTOM;

            CustomPaperInfo customPaperInfo = CustomPaperInfo.newCustomDiaCutPaper(
                    settings.printerModel,
                    Unit.Mm,
                    51.0f,
                    26.0f,
                    0,
                    0,
                    0,
                    0,
                    29.0f
            );

            List<Map<CustomPaperInfo.ErrorParameter, CustomPaperInfo.ErrorDetail>> errors = settings.setCustomPaperInfo(customPaperInfo);
            if (errors.isEmpty() == false) {
                for(final Map<CustomPaperInfo.ErrorParameter, CustomPaperInfo.ErrorDetail> error: errors) {
                    for (final Map.Entry<CustomPaperInfo.ErrorParameter, CustomPaperInfo.ErrorDetail> entry: error.entrySet()) {
                        Log.d("BrotherPrinterPlugin", entry.getKey().toString() + " " + entry.getValue().message);
                    }
                }

                completion.completion(new PrinterErrorException(PrinterInfo.ErrorCode.ERROR_WRONG_LABEL));
                return;
            }
        }
        else if (model == PrinterInfo.Model.QL_820NWB) {
            settings.labelNameIndex = LabelInfo.QL700.W62RB.ordinal();
        }

        printer.setPrinterInfo(settings);

        new Thread(new Runnable() {
            @Override
            public void run() {
                Log.d("BrotherPrinterPlugin", "Start print");

                PrinterInfo.ErrorCode errorCode = null;

                try {
                    if (printer.startCommunication()) {
                        Log.d("BrotherPrinterPlugin", "Communication stared");

                        PrinterStatus result = printer.printPdfFile(path, 1);
                        if (result.errorCode != PrinterInfo.ErrorCode.ERROR_NONE) {
                            errorCode = result.errorCode;
                            Log.d("BrotherPrinterPlugin", "ERROR - " + errorCode.toString());
                        }
                        printer.endCommunication();

                        if (errorCode != null) {
                            completion.completion(new PrinterErrorException(errorCode));
                        }
                        else {
                            completion.completion(null);
                        }
                    }
                    else {
                        completion.completion(new Exception("Failed to start communication"));
                    }
                } catch (Exception e) {
                    Log.d("BrotherPrinterPlugin", "Exception - " + e.getMessage());
                    completion.completion(e);
                }
            }
        }).start();
    }

}
