import 'package:alpha_french_fries/alu_model.dart';
import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/bt_service.dart';
import 'package:alpha_french_fries/get_bits.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class InstructionWidget extends StatefulWidget {
  final ALUNotifier aluNotifier;
  final BTService bluetoothService;
  const InstructionWidget({
    super.key,
    required this.aluNotifier,
    required this.bluetoothService,
  });

  @override
  State<InstructionWidget> createState() => InstructionWidgetState();
}

class InstructionWidgetState extends State<InstructionWidget> {
  @override
  void initState() {
    widget.bluetoothService.connect();
    widget.aluNotifier.addListener(() {
      final alu = widget.aluNotifier.value;
      widget.bluetoothService.sendData(alu.raw);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: vars.itemSpacing,
        children: [
          ValueListenableBuilder<ALUModel>(
            valueListenable: widget.aluNotifier,
            builder: (_, alu, _) {
              final bits = getBits(alu.raw);
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
