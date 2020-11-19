import 'dart:async';
import 'package:mdns_plugin/mdns_plugin.dart';

import 'device.dart';
import 'model.dart';

class BrotherDiscoveryService {
  static final BrotherDiscoveryService _instance = BrotherDiscoveryService._();
  BrotherDiscoveryService._();

  factory BrotherDiscoveryService() {
    return _instance;
  }

  List<BrotherDevice> get devices => _delegate.devices ?? <BrotherDevice>[];

  Stream<List<BrotherDevice>> get stream => _controller?.stream;
  StreamController<List<BrotherDevice>> _controller;

  MDNSPlugin _mdns;
  _Delegate _delegate;

  Future<void> start() async {
    if (_mdns == null) {
      _controller = StreamController<List<BrotherDevice>>.broadcast();
      _delegate = _Delegate(_controller);
      _mdns = MDNSPlugin(_delegate);
      await _mdns.startDiscovery('_printer._tcp', enableUpdating: true);
    }
  }

  Future<void> stop() async {
    await _mdns?.stopDiscovery();
    await _controller?.close();
    _controller = null;
    _delegate = null;
    _mdns = null;
  }
}

class _Delegate implements MDNSPluginDelegate {
  final devices = <BrotherDevice>[];
  final StreamController<List<BrotherDevice>> controller;

  _Delegate(this.controller);

  @override
  bool onServiceFound(MDNSService service) {
    return true;
  }

  @override
  void onServiceResolved(MDNSService service) {
    devices.removeWhere((x) => x.modelName == service.name);

    final newDevices = _transformServiceInDevices(service);
    if (newDevices != null) {
      devices.addAll(newDevices);
    }

    controller.sink.add(devices);
  }

  @override
  void onServiceUpdated(MDNSService service) {}

  @override
  void onServiceRemoved(MDNSService service) {
    devices.removeWhere((x) => x.modelName == service.name);
    controller.sink.add(devices);
  }

  @override
  void onDiscoveryStarted() {}

  @override
  void onDiscoveryStopped() {}

  static List<BrotherDevice> _transformServiceInDevices(MDNSService service) {
    final name = service.name;
    final model = brotherModels.firstWhere((x) => x.nameIOS == name, orElse: () => null);

    if (model == null) {
      return null;
    }

    return service.addresses
        .map((address) => BrotherDevice(
              source: BrotherDeviceSource.network,
              model: model,
              modelName: name,
              ipAddress: address,
            ))
        .toList();
  }
}
