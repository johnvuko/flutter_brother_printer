package co.eivo.brother_printer;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.util.Log;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;

import com.brother.ptouch.sdk.CustomPaperInfo;
import com.brother.ptouch.sdk.LabelInfo;
import com.brother.ptouch.sdk.Printer;
import com.brother.ptouch.sdk.PrinterInfo;
import com.brother.ptouch.sdk.PrinterStatus;
import com.brother.ptouch.sdk.Unit;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Arrays;

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

    static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    private final BroadcastReceiver mUsbReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (ACTION_USB_PERMISSION.equals(action)) {
                synchronized (this) {
                    if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                        //
                    } else {
                        //
                    }

                }
            }
        }
    };

    void print(Activity activity, Context context, int modelCode, final String path, int copies, String ipAddress,
            String macAddress, String bleAdvertiseLocalName, String paperSettingsPath, String labelSize,
            final BRPrinterSessionCompletion completion) {
        PrinterInfo.Model model = PrinterInfo.Model.valueFromID(modelCode);

        List<PrinterInfo.Model> qlSeries = new ArrayList<PrinterInfo.Model>(Arrays.asList(PrinterInfo.Model.QL_710W,
                PrinterInfo.Model.QL_720NW, PrinterInfo.Model.QL_810W, PrinterInfo.Model.QL_820NWB));
        List<PrinterInfo.Model> ptSeries = new ArrayList<PrinterInfo.Model>(
                Arrays.asList(PrinterInfo.Model.PT_E550W, PrinterInfo.Model.PT_P750W, PrinterInfo.Model.PT_E850TKW,
                        PrinterInfo.Model.PT_D800W, PrinterInfo.Model.PT_P900W, PrinterInfo.Model.PT_P950NW,
                        PrinterInfo.Model.PT_E800W, PrinterInfo.Model.PT_E500, PrinterInfo.Model.PT_P910BT));

        final Printer printer = new Printer();
        final PrinterInfo settings = printer.getPrinterInfo();
        settings.printerModel = model;
        settings.workPath = context.getFilesDir().getAbsolutePath();
        settings.isAutoCut = true;
        settings.printMode = PrinterInfo.PrintMode.FIT_TO_PAGE;
        settings.numberOfCopies = copies;

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
        } else {
            settings.port = PrinterInfo.Port.USB;

            UsbManager usbManager = (UsbManager) activity.getSystemService(Context.USB_SERVICE);
            UsbDevice usbDevice = printer.getUsbDevice(usbManager);
            if (usbDevice == null) {
                Log.d("BrotherPrinterPlugin", "no USB device");
                completion.completion(new Exception("no USB device"));
                return;
            }
            PendingIntent permissionIntent = PendingIntent.getBroadcast(activity, 0, new Intent(ACTION_USB_PERMISSION),
                    0);
            activity.registerReceiver(mUsbReceiver, new IntentFilter(ACTION_USB_PERMISSION));
            if (!usbManager.hasPermission(usbDevice)) {
                usbManager.requestPermission(usbDevice, permissionIntent);
            }
        }

        if (model == PrinterInfo.Model.TD_2120N || model == PrinterInfo.Model.TD_2130N) {
            if (paperSettingsPath == null) {
                Log.d("BrotherPrinterPlugin", "no paperSettingsPath");
                completion.completion(new PrinterErrorException(PrinterInfo.ErrorCode.ERROR_WRONG_LABEL));
                return;
            }

            settings.paperSize = PrinterInfo.PaperSize.CUSTOM;
            settings.customPaper = paperSettingsPath;

            // CustomPaperInfo customPaperInfo = CustomPaperInfo.newCustomDiaCutPaper(
            // settings.printerModel,
            // Unit.Mm,
            // 51.0f,
            // 26.0f,
            // 0,
            // 0,
            // 0,
            // 0,
            // 29.0f
            // );

            // List<Map<CustomPaperInfo.ErrorParameter, CustomPaperInfo.ErrorDetail>> errors
            // = settings.setCustomPaperInfo(customPaperInfo);
            // if (errors.isEmpty() == false) {
            // for(final Map<CustomPaperInfo.ErrorParameter, CustomPaperInfo.ErrorDetail>
            // error: errors) {
            // for (final Map.Entry<CustomPaperInfo.ErrorParameter,
            // CustomPaperInfo.ErrorDetail> entry: error.entrySet()) {
            // Log.d("BrotherPrinterPlugin", entry.getKey().toString() + " " +
            // entry.getValue().message);
            // }
            // }

            // completion.completion(new
            // PrinterErrorException(PrinterInfo.ErrorCode.ERROR_WRONG_LABEL));
            // return;
            // }
        } else if (qlSeries.contains(model)) {
            LabelInfo.QL700 qlLabelSize;

            switch (labelSize) {
                case "DieCutW17H54":
                    qlLabelSize = LabelInfo.QL700.W17H54;
                    break;
                case "DieCutW17H87":
                    qlLabelSize = LabelInfo.QL700.W17H87;
                    break;
                case "DieCutW23H23":
                    qlLabelSize = LabelInfo.QL700.W23H23;
                    break;
                case "DieCutW29H42":
                    qlLabelSize = LabelInfo.QL700.W29H42;
                    break;
                case "DieCutW29H90":
                    qlLabelSize = LabelInfo.QL700.W29H90;
                    break;
                case "DieCutW38H90":
                    qlLabelSize = LabelInfo.QL700.W38H90;
                    break;
                case "DieCutW39H48":
                    qlLabelSize = LabelInfo.QL700.W39H48;
                    break;
                case "DieCutW52H29":
                    qlLabelSize = LabelInfo.QL700.W52H29;
                    break;
                case "DieCutW62H29":
                    qlLabelSize = LabelInfo.QL700.W62H29;
                    break;
                case "DieCutW62H100":
                    qlLabelSize = LabelInfo.QL700.W62H100;
                    break;
                case "RollW12":
                    qlLabelSize = LabelInfo.QL700.W12;
                    break;
                case "RollW29":
                    qlLabelSize = LabelInfo.QL700.W29;
                    break;
                case "RollW38":
                    qlLabelSize = LabelInfo.QL700.W38;
                    break;
                case "RollW50":
                    qlLabelSize = LabelInfo.QL700.W50;
                    break;
                case "RollW54":
                    qlLabelSize = LabelInfo.QL700.W54;
                    break;
                case "RollW62":
                    qlLabelSize = LabelInfo.QL700.W62;
                    break;
                case "DieCutW60H86":
                    qlLabelSize = LabelInfo.QL700.W60H86;
                    break;
                case "DieCutW54H29":
                    qlLabelSize = LabelInfo.QL700.W54H29;
                    break;
                case "RollW62RB":
                    qlLabelSize = LabelInfo.QL700.W62RB;
                    break;
                default:
                    completion.completion(new Exception("Invalid label size"));
                    return;
            }

            settings.labelNameIndex = qlLabelSize.ordinal();
        } else if (ptSeries.contains(model)) {
            LabelInfo.PT printerLabelSize;

            switch (labelSize) {
                case "3_5mm":
                    printerLabelSize = LabelInfo.PT.W3_5;
                    break;
                case "6mm":
                    printerLabelSize = LabelInfo.PT.W6;
                    break;
                case "9mm":
                    printerLabelSize = LabelInfo.PT.W9;
                    break;
                case "12mm":
                    printerLabelSize = LabelInfo.PT.W12;
                    break;
                case "18mm":
                    printerLabelSize = LabelInfo.PT.W18;
                    break;
                case "24mm":
                    printerLabelSize = LabelInfo.PT.W24;
                    break;
                case "36mm":
                    printerLabelSize = LabelInfo.PT.W36;
                    break;
                default:
                    completion.completion(new Exception("Invalid label size"));
                    return;
            }

            settings.labelNameIndex = printerLabelSize.ordinal();
        }

        printer.setPrinterInfo(settings);

        new Thread(new Runnable() {
            @Override
            public void run() {
                Log.d("BrotherPrinterPlugin", "Start print");

                PrinterInfo.ErrorCode errorCode = null;

                try {
                    if (printer.startCommunication()) {
                        Log.d("BrotherPrinterPlugin", "Communication started");

                        int pages = printer.getPDFFilePages(path);
                        for (int page = 1; page <= pages; page++) {
                            PrinterStatus result = printer.printPdfFile(path, page);
                            if (result.errorCode != PrinterInfo.ErrorCode.ERROR_NONE) {
                                errorCode = result.errorCode;
                                Log.d("BrotherPrinterPlugin", "ERROR - " + errorCode.toString());
                            }
                        }
                        printer.endCommunication();

                        if (errorCode != null) {
                            completion.completion(new PrinterErrorException(errorCode));
                        } else {
                            completion.completion(null);
                        }
                    } else {
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
