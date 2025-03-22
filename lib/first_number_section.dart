import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class FirstNumberSection extends StatefulWidget {
  final ALUNotifier aluNotifier;
  const FirstNumberSection({super.key, required this.aluNotifier});

  @override
  State<FirstNumberSection> createState() => FirstNumberSectionState();
}

class FirstNumberSectionState extends State<FirstNumberSection> {
  int _firstNumber = 0;

  void setFirstNumber(int number) {
    widget.aluNotifier.setInputA(number);
    setState(() {
      _firstNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: vars.itemSpacing,
        children: [
          Row(
            spacing: vars.itemSpacing,
            children: [
              ToggleButton(
                checked: _firstNumber == 0,
                child: Text("0"),
                onChanged: (state) => state ? setFirstNumber(0) : null,
              ),
              ToggleButton(
                checked: _firstNumber == 1,
                child: Text("1"),
                onChanged: (state) => state ? setFirstNumber(1) : null,
              ),
              ToggleButton(
                checked: _firstNumber == 2,
                child: Text("2"),
                onChanged: (state) => state ? setFirstNumber(2) : null,
              ),
              ToggleButton(
                checked: _firstNumber == 3,
                child: Text("3"),
                onChanged: (state) => state ? setFirstNumber(3) : null,
              ),
            ],
          ),
          Text("First Number"),
        ],
      ),
    );
  }
}
