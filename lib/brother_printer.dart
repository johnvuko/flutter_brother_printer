import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'device.dart';
import 'label_size.dart';
import 'model.dart';

export 'device.dart';
export 'label_size.dart';
export 'model.dart';

const MethodChannel _channel = MethodChannel('brother_printer');

class BrotherPrinter {
  static Future<List<BrotherDevice>> searchDevices({
    int delay = 5,
    bool searchOnIPv6 = false,
  }) async {
    assert(delay > 0);

    List<String> printerNames;

    if (Platform.isIOS) {
      printerNames = brotherModels.map((x) => x.nameIOS).toList();
    } else if (Platform.isAndroid) {
      printerNames = brotherModels.map((x) => x.nameAndroid).toList();
    } else {
      throw UnimplementedError();
    }

    final List rawDevices = await _channel.invokeMethod('searchDevices', {
      'delay': delay,
      'isEnableIPv6Search': searchOnIPv6,
      'printerNames': printerNames,
    });

    final devices =
        rawDevices.map((x) => Map<String, String?>.from(x)).map((x) => BrotherDevice.fromJson(x)).whereType<BrotherDevice>().toList();
    return devices.toSet().toList();
  }

  static Future<void> printPDF({
    required String path,
    required BrotherDevice device,
    String? paperSettingsPath,
    BrotherLabelSize? labelSize,
    int copies = 1,
  }) async {
    assert(copies > 0);

    int modelCode;

    if (Platform.isIOS) {
      modelCode = device.model.codeIOS;
    } else if (Platform.isAndroid) {
      modelCode = device.model.codeAndroid;
    } else {
      throw UnimplementedError();
    }

    await _channel.invokeMethod('printPDF', {
      'path': path,
      'copies': copies,
      'modelCode': modelCode,
      'ipAddress': device.ipAddress,
      'macAddress': device.macAddress,
      'serialNumber': device.serialNumber,
      'bleAdvertiseLocalName': device.bleAdvertiseLocalName,
      'paperSettingsPath': paperSettingsPath,
      'labelSize': labelSize?.toParam(),
    });
  }
}
