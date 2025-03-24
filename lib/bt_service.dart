import 'package:alpha_french_fries/bt_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';

class BTService extends ValueNotifier<BTModel> {
  BTService(super.state);

  BluetoothStreamSink? sink;

  BluetoothConnection? connection;

  Future<void> connect() async {
    int tries = 0;
    while (tries < 10) {
      await _connectToArduino();
      if (connection == null) {
        tries++;
        value = value.copyWith(status: "Retrying $tries...");
        await Future.delayed(const Duration(seconds: 2));
      } else {
        return;
      }
    }
    value = value.copyWith(status: "Failed to connect");
  }

  Future<void> _connectToArduino() async {
    final FlutterBlueClassic blueClassic = FlutterBlueClassic(
      usesFineLocation: true,
    );
    final List<BluetoothDevice>? listDev = await blueClassic.bondedDevices;

    if (listDev == null) {
      value = value.copyWith(status: "No paired devices");
      return;
    }

    final String targetDeviceName = "HC06";

    for (BluetoothDevice device in listDev) {
      if (device.name == targetDeviceName) {
        try {
          connection = await blueClassic.connect(device.address);
        } catch (e) {
          return;
        }
        break;
      }
    }

    if (connection == null) {
      value = value.copyWith(status: "Pair with '$targetDeviceName' first");
      return;
    }

    connection?.input?.listen(onDataReceived);

    sink = connection?.output;
    value = value.copyWith(status: "Connected to $targetDeviceName");
  }

  Future<void> onDataReceived(Uint8List data) async {
    bool isEnd = String.fromCharCodes(data) == "\r\n";
    if (!isEnd) {
      value = value.copyWith(byte: data);
    }
  }

  void sendData(Uint8List data) {
    if (sink?.isConnected == true) {
      sink?.add(data);
    } else {
      value = value.copyWith(status: "Not connected");
      connect();
    }
  }

  @override
  void dispose() {
    value = value.copyWith(status: "Disconnected");
    super.dispose();
    sink?.close();
    connection?.finish();
  }
}
