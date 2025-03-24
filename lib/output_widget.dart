import 'package:alpha_french_fries/alu_model.dart';
import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/bt_model.dart';
import 'package:alpha_french_fries/bt_service.dart';
import 'package:alpha_french_fries/get_bits.dart';
import 'package:alpha_french_fries/operation.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';

class OutputWidget extends StatefulWidget {
  final ALUNotifier aluNotifier;
  final BTService bluetoothService;
  const OutputWidget({
    super.key,
    required this.aluNotifier,
    required this.bluetoothService,
  });

  @override
  State<OutputWidget> createState() => OutputWidgetState();
}

class OutputWidgetState extends State<OutputWidget> {
  final SvgPicture ledOff = SvgPicture.asset('assets/led_off.svg');

  final SvgPicture ledOn = SvgPicture.asset('assets/led_on.svg');

  List<int> calculateResult(int a, int b, Operation op) {
    int result;
    int carry = 0;

    // Ensure a and b are treated as 2-bit numbers
    a = a & 3;
    b = b & 3;

    // Perform the 2-bit operation
    switch (op) {
      case Operation.addition:
        result = (a + b) & 3;
        carry = (a + b) >> 2;
        break;
      case Operation.negation:
        result = (~a) & 3;
        carry = 0;
        break;
      case Operation.and:
        result = (a & b) & 3;
        carry = 0;
        break;
      case Operation.or:
        result = (a | b) & 3;
        carry = 0;
        break;
      case Operation.leftShift:
        result = (a << 1) & 3;
        carry = (a >> 1) & 3;
        break;
      case Operation.subtraction:
        result = (a - b) & 3;
        carry = (a - b) >> 2;
        break;
      case Operation.rightShift:
        result = (a >> 1) & 3;
        carry = (a << 1) & 3;
        break;
      case Operation.increment:
        result = (a + 1) & 3;
        carry = (a + 1) >> 2;
        break;
      case Operation.decrement:
        result = (a - 1) & 3;
        carry = (a - 1) >> 2;
        break;
      case Operation.xor:
        result = (a ^ b) & 3;
        carry = 0;
        break;
    }

    // Convert result and carry to 2-bit binary representation
    List<int> resultBits = [
      (carry & 1) == 1 ? 1 : 0,
      (result & 2) == 2 ? 1 : 0,
      (result & 1) == 1 ? 1 : 0,
    ];
    return resultBits;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: vars.sectionSpacing,
        children: [
          Expanded(
            child: Card(
              child: Column(
                spacing: vars.itemSpacing,
                children: [
                  Expanded(
                    child: ValueListenableBuilder<ALUModel>(
                      valueListenable: widget.aluNotifier,
                      builder: (_, alu, _) {
                        final result = calculateResult(
                          alu.inputA,
                          alu.inputB,
                          Operation.values[alu.operation],
                        );

                        final carry = result[0] == 1 ? ledOn : ledOff;
                        final msb = result[1] == 1 ? ledOn : ledOff;
                        final lsb = result[2] == 1 ? ledOn : ledOff;

                        return Row(
                          spacing: vars.itemSpacing,
                          children: [
                            Card(child: carry),
                            Divider(direction: Axis.vertical),
                            Row(children: [Card(child: msb), Card(child: lsb)]),
                          ],
                        );
                      },
                    ),
                  ),
                  Text("Expected"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Column(
                spacing: vars.itemSpacing,
                children: [
                  Expanded(
                    child: ValueListenableBuilder<BTModel>(
                      valueListenable: widget.bluetoothService,
                      builder: (_, value, _) {
                        List<int> data = getBits(value.byte);

                        final carry = data[5] == 1 ? ledOn : ledOff;
                        final msb = data[6] == 1 ? ledOn : ledOff;
                        final lsb = data[7] == 1 ? ledOn : ledOff;

                        return Row(
                          spacing: vars.itemSpacing,
                          children: [
                            Card(child: carry),
                            Divider(direction: Axis.vertical),
                            Row(children: [Card(child: msb), Card(child: lsb)]),
                          ],
                        );
                      },
                    ),
                  ),
                  Text("Result"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
