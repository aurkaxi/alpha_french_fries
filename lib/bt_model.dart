import 'dart:typed_data';

class BTModel {
  final String _status;
  final Uint8List _byte;

  BTModel._internal(this._status, this._byte);

  factory BTModel() {
    final byte = Uint8List(1);
    final model = BTModel._internal("Not Connected", byte);
    return model;
  }

  BTModel copyWith({String? status, Uint8List? byte}) {
    return BTModel._internal(status ?? _status, byte ?? _byte);
  }

  String get status => _status;
  Uint8List get byte => _byte;
}
