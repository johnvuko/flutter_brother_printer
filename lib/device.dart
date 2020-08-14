import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'model.dart';

enum BrotherDeviceSource {
  network,
  bluetooth,
  ble,
}

class BrotherDevice extends Equatable {
  final String ipAddress;
  final String location;
  final String modelName;
  final String printerName;
  final String serialNumber;
  final String nodeName;
  final String macAddress;
  final String bleAdvertiseLocalName;
  final BrotherDeviceSource source;
  final BrotherModel model;

  /// For iOS must set at least `ipAddress` or `serialNumber`or `bleAdvertiseLocalName`
  /// For Android must set at least `ipAddress` or `macAddress` or `bleAdvertiseLocalName`
  const BrotherDevice({
    @required this.source,
    @required this.model,
    this.ipAddress,
    this.location,
    this.modelName,
    this.printerName,
    this.serialNumber,
    this.nodeName,
    this.macAddress,
    this.bleAdvertiseLocalName,
  });

  BrotherDevice.fromJson(Map<String, String> json)
      : ipAddress = json['ipAddress'],
        location = json['location'],
        modelName = json['modelName'],
        printerName = json['printerName'],
        serialNumber = json['serialNumber'],
        nodeName = json['nodeName'],
        macAddress = json['macAddress'],
        bleAdvertiseLocalName = json['bleAdvertiseLocalName'],
        source = _findSource(json['source']),
        model = _findModel(json['modelName'], json['printerName'], json['bleAdvertiseLocalName'], json['source'] == 'bluetooth');

  @override
  List<Object> get props => [
        source,
        ipAddress,
        location,
        modelName,
        printerName,
        serialNumber,
        nodeName,
        macAddress,
        bleAdvertiseLocalName,
        model,
      ];

  Map<String, String> toJson() {
    return {
      'source': source.toString(),
      'ipAddress': ipAddress,
      'location': location,
      'modelName': modelName,
      'printerName': printerName,
      'serialNumber': serialNumber,
      'nodeName': nodeName,
      'macAddress': macAddress,
      'bleAdvertiseLocalName': bleAdvertiseLocalName,
    };
  }

  String get name {
    return [
      printerName,
      modelName,
      bleAdvertiseLocalName,
      nodeName,
      ipAddress,
      serialNumber,
      macAddress,
    ].where((x) => x != null).first;
  }

  static BrotherModel _findModel(String modelName, String printerlName, String bleAdvertiseLocalName, bool isBluetooth) {
    final model = brotherModels.firstWhere((model) {
      final texts = [
        modelName,
        bleAdvertiseLocalName,
        printerlName,
      ].where((x) => x != null).map((x) => x.replaceAll('_', '-').replaceAll('Brother', '').replaceAll(' ', '')).toList();

      return texts.any((x) => x.contains(model.nameAndroid));
    }, orElse: () => null);

    if (model == null) {
      // on Android get every paired bluetooth devices without filtering Brother's printers
      // so doesn't display a warning in this case and just ignore the device
      if (!(isBluetooth && Platform.isAndroid)) {
        print('[BrotherDevice] cannot find printer model with modelName $modelName - printerlName $printerlName - bleAdvertiseLocalName: $bleAdvertiseLocalName');
      }
    }

    return model;
  }

  static BrotherDeviceSource _findSource(String source) {
    switch (source) {
      case 'network':
        return BrotherDeviceSource.network;
      case 'bluetooth':
        return BrotherDeviceSource.bluetooth;
      case 'ble':
        return BrotherDeviceSource.ble;
    }

    throw '[BrotherDevice] invalid source $source';
  }
}
