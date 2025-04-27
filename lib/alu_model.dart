import 'dart:typed_data';

import 'package:alpha_french_fries/operation.dart';

class ALUModel {
  final Uint8List _byte;
  final Operation _op;

  ALUModel._internal(this._byte, this._op);

  /// Constructor — always creates with 1 byte
  factory ALUModel() {
    final data = Uint8List(1); // 1 byte = 8 bits
    final model = ALUModel._internal(data, Operation.addition);
    return model;
  }

  /// Copy with modified values
  ALUModel copyWith({Operation? operation, int? inputA, int? inputB}) {
    final newByte = Uint8List(1);
    final opCode = operationMap[operation ?? _op] ?? 0;
    newByte[0] = _byte[0]; // Copy current byte

    if (inputA != null) {
      newByte[0] = (newByte[0] & ~(3 << 6)) | ((inputA & 3) << 6);
    }
    if (inputB != null) {
      newByte[0] = (newByte[0] & ~(3 << 4)) | ((inputB & 3) << 4);
    }
    if (operation != null) {
      newByte[0] = (newByte[0] & ~15) | (opCode & 15);
    }

    return ALUModel._internal(newByte, operation ?? _op);
  }

  /// Getters
  int get inputA => (_byte[0] >> 6) & 3;
  int get inputB => (_byte[0] >> 4) & 3;
  int get opCode => _byte[0] & 15;
  Operation get operation => _op;

  Uint8List get raw => Uint8List.fromList(_byte); // Safe copy

  @override
  String toString() {
    return 'ALUModel(op: $opCode, A: $inputA, B: $inputB, byte: 0x${_byte[0].toRadixString(16).padLeft(2, '0').toUpperCase()})';
  }
}
