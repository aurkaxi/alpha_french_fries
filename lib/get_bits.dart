import 'dart:typed_data';

List<int> getBits(Uint8List byte) {
  return List.generate(8, (index) => (byte[0] >> (7 - index)) & 1);
}
