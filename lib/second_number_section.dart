import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/operation.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class SecondNumberSection extends StatefulWidget {
  final ALUNotifier aluNotifier;
  const SecondNumberSection({super.key, required this.aluNotifier});

  @override
  State<SecondNumberSection> createState() => SecondNumberSectionState();
}

class SecondNumberSectionState extends State<SecondNumberSection> {
  int _secondNumber = 0;
  bool isIncrementOrDecrement = false;

  void setSecondNumber(int number) {
    if (isIncrementOrDecrement) {
      return;
    }
    widget.aluNotifier.setInputB(number);
    setState(() {
      _secondNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: vars.itemSpacing,
        children: [
          ValueListenableBuilder(
            valueListenable: widget.aluNotifier,
            builder: (_, alu, _) {
              final bits = alu.operation;
              isIncrementOrDecrement =
                  bits == Operation.increment || bits == Operation.decrement;

              if (isIncrementOrDecrement) {
                _secondNumber = 1;
              }

              return Row(
                spacing: vars.itemSpacing,
                children: [
                  ToggleButton(
                    checked: _secondNumber == 0,
                    child: Text("0"),
                    onChanged: (state) => state ? setSecondNumber(0) : null,
                  ),
                  ToggleButton(
                    checked: _secondNumber == 1,
                    child: Text("1"),
                    onChanged: (state) => state ? setSecondNumber(1) : null,
                  ),
                  ToggleButton(
                    checked: _secondNumber == 2,
                    child: Text("2"),
                    onChanged: (state) => state ? setSecondNumber(2) : null,
                  ),
                  ToggleButton(
                    checked: _secondNumber == 3,
                    child: Text("3"),
                    onChanged: (state) => state ? setSecondNumber(3) : null,
                  ),
                ],
              );
            },
          ),
          Text("Second Number"),
        ],
      ),
    );
  }
}
