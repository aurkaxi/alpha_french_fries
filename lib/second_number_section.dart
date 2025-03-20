import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class SecondNumberSection extends StatefulWidget {
  const SecondNumberSection({super.key});

  @override
  State<SecondNumberSection> createState() => SecondNumberSectionState();
}

class SecondNumberSectionState extends State<SecondNumberSection> {
  int _secondNumber = 0;

  void setSecondNumber(int number) {
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
          Row(
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
          ),
          Text("Second Number"),
        ],
      ),
    );
  }
}
