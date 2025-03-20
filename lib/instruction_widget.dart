import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class InstructionWidget extends StatefulWidget {
  const InstructionWidget({super.key});

  @override
  State<InstructionWidget> createState() => InstructionWidgetState();
}

class InstructionWidgetState extends State<InstructionWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: vars.itemSpacing,
        children: [
          Row(
            spacing: vars.itemSpacing,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [Card(child: Text('0')), Card(child: Text('0'))]),
              Row(children: [Card(child: Text('0')), Card(child: Text('0'))]),
              Row(
                children: [
                  Card(child: Text('0')),
                  Card(child: Text('0')),
                  Card(child: Text('0')),
                  Card(child: Text('0')),
                ],
              ),
            ],
          ),
          Text("Instruction"),
        ],
      ),
    );
  }
}
