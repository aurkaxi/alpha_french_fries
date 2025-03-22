import 'package:alpha_french_fries/alu_model.dart';
import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class InstructionWidget extends StatefulWidget {
  final ALUNotifier aluNotifier;
  const InstructionWidget({super.key, required this.aluNotifier});

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
          ValueListenableBuilder<ALUModel>(
            valueListenable: widget.aluNotifier,
            builder: (_, alu, _) {
              final bits = alu.getBits();

              return Row(
                spacing: vars.itemSpacing,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Card(child: Text('${bits[0]}')),
                      Card(child: Text('${bits[1]}')),
                    ],
                  ),
                  Row(
                    children: [
                      Card(child: Text('${bits[2]}')),
                      Card(child: Text('${bits[3]}')),
                    ],
                  ),
                  Row(
                    children: [
                      Card(child: Text('${bits[4]}')),
                      Card(child: Text('${bits[5]}')),
                      Card(child: Text('${bits[6]}')),
                      Card(child: Text('${bits[7]}')),
                    ],
                  ),
                ],
              );
            },
          ),
          Text("Instruction"),
        ],
      ),
    );
  }
}
