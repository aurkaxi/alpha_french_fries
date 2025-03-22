import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';

class OutputWidget extends StatefulWidget {
  final ALUNotifier aluNotifier;
  const OutputWidget({super.key, required this.aluNotifier});

  @override
  State<OutputWidget> createState() => OutputWidgetState();
}

class OutputWidgetState extends State<OutputWidget> {
  final SvgPicture ledOff = SvgPicture.asset('assets/led_off.svg');

  final SvgPicture ledOn = SvgPicture.asset('assets/led_on.svg');

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
                    child: Row(
                      spacing: vars.itemSpacing,
                      children: [
                        Card(child: ledOff),
                        Divider(direction: Axis.vertical),
                        Row(
                          children: [Card(child: ledOn), Card(child: ledOff)],
                        ),
                      ],
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
                    child: Row(
                      spacing: vars.itemSpacing,
                      children: [
                        Card(child: ledOn),
                        Divider(direction: Axis.vertical),
                        Row(
                          children: [Card(child: ledOff), Card(child: ledOn)],
                        ),
                      ],
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
