import 'dart:async';
import 'dart:io';
import 'package:pedantic/pedantic.dart';

import 'package:flutter/services.dart';
import 'device.dart';
import 'discovery.dart';
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
    bool searchWithmDNS = true,
  }) async {
    if (searchWithmDNS) {
      unawaited(BrotherDiscoveryService().start());
    } else {
      unawaited(BrotherDiscoveryService().stop());
    }

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

    final devices = rawDevices.map((x) => Map<String, String>.from(x)).map((x) => BrotherDevice.fromJson(x)).where((x) => x.model != null).toList();
    if (searchWithmDNS) {
      final newDevices = List<BrotherDevice>.from(BrotherDiscoveryService().devices);
      newDevices.removeWhere((x) => devices.any((y) => y.source == BrotherDeviceSource.network && y.ipAddress == x.ipAddress));
      devices.addAll(newDevices);
    }
    return devices.toSet().toList();
  }

  static Future<void> printPDF({String path, BrotherDevice device, String paperSettingsPath, BrotherLabelSize labelSize, int copies = 1}) async {
    assert(path != null);
    assert(device != null);
    assert(copies > 0);

    int modelCode;

    if (Platform.isIOS) {
      modelCode = device.model.codeIOS;
    } else if (Platform.isAndroid) {
      modelCode = device.model.codeAndroid;
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
