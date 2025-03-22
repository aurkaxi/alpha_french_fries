import 'dart:typed_data';

class ALUModel {
  final Uint8List _byte;

  ALUModel._internal(this._byte);

  /// Constructor — always creates with 1 byte
  factory ALUModel() {
    final data = Uint8List(1); // 1 byte = 8 bits
    final model = ALUModel._internal(data);
    return model;
  }

  /// Copy with modified values
  ALUModel copyWith({int? operation, int? inputA, int? inputB}) {
    final newByte = Uint8List(1);
    newByte[0] = _byte[0]; // Copy current byte

    if (inputA != null) {
      newByte[0] = (newByte[0] & ~(3 << 6)) | ((inputA & 3) << 6);
    }
    if (inputB != null) {
      newByte[0] = (newByte[0] & ~(3 << 4)) | ((inputB & 3) << 4);
    }
    if (operation != null) {
      newByte[0] = (newByte[0] & ~15) | (operation & 15);
    }

    return ALUModel._internal(newByte);
  }

  /// Getters
  int get inputA => (_byte[0] >> 6) & 3;
  int get inputB => (_byte[0] >> 4) & 3;
  int get operation => _byte[0] & 15;

  Uint8List get raw => Uint8List.fromList(_byte); // Safe copy

  @override
  String toString() {
    return 'ALUModel(op: $operation, A: $inputA, B: $inputB, byte: 0x${_byte[0].toRadixString(16).padLeft(2, '0').toUpperCase()})';
  }

  List<int> getBits() {
    return List.generate(8, (index) => (_byte[0] >> (7 - index)) & 1);
  }
}
