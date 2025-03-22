import 'package:alpha_french_fries/operation.dart';
import 'package:flutter/foundation.dart';

import 'alu_model.dart'; // Assuming ALUModel is in another file

class ALUNotifier extends ValueNotifier<ALUModel> {
  ALUNotifier(super.state);

  void setInputA(int a) {
    value = value.copyWith(inputA: a);
  }

  void setInputB(int b) {
    value = value.copyWith(inputB: b);
  }

  void setOperation(Operation op) {
    value = value.copyWith(operation: op.index);
  }
}
