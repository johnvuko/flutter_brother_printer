import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'device.dart';
import 'model.dart';

export 'device.dart';
export 'model.dart';

const MethodChannel _channel = MethodChannel('brother_printer');

class BrotherPrinter {
  static Future<List<BrotherDevice>> searchDevices({
    int delay = 5,
    bool isEnableIPv6Search = false,
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

    final List devices = await _channel.invokeMethod('searchDevices', {
      'delay': delay,
      'isEnableIPv6Search': isEnableIPv6Search,
      'printerNames': printerNames,
    });

    return devices.map((x) => Map<String, String>.from(x)).map((x) => BrotherDevice.fromJson(x)).where((x) => x.model != null).toList();
  }

  static Future<void> printPDF(String path, BrotherDevice device) async {
    int modelCode;

    if (Platform.isIOS) {
      modelCode = device.model.codeIOS;
    } else if (Platform.isAndroid) {
      modelCode = device.model.codeAndroid;
    }

    await _channel.invokeMethod('printPDF', {
      'path': path,
      'modelCode': modelCode,
      'ipAddress': device.ipAddress,
      'macAddress': device.macAddress,
      'serialNumber': device.serialNumber,
      'bleAdvertiseLocalName': device.bleAdvertiseLocalName,
    });
  }
}
