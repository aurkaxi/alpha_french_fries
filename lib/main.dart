import 'package:alpha_french_fries/first_number_section.dart';
import 'package:alpha_french_fries/instruction_widget.dart';
import 'package:alpha_french_fries/operation_section.dart';
import 'package:alpha_french_fries/output_widget.dart';
import 'package:alpha_french_fries/second_number_section.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  GlobalKey<OperationSectionState> operationKey =
      GlobalKey<OperationSectionState>();
  GlobalKey<FirstNumberSectionState> firstNumberKey =
      GlobalKey<FirstNumberSectionState>();
  GlobalKey<SecondNumberSectionState> secondNumberKey =
      GlobalKey<SecondNumberSectionState>();
  GlobalKey<InstructionWidgetState> instructionKey =
      GlobalKey<InstructionWidgetState>();
  GlobalKey<OutputWidgetState> outputKey = GlobalKey<OutputWidgetState>();

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: FluentThemeData(brightness: Brightness.light),
      darkTheme: FluentThemeData(brightness: Brightness.dark),
      home: ScaffoldPage(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: vars.sectionSpacing,
            children: [
              OperationSection(key: operationKey),
              Expanded(
                child: Row(
                  spacing: vars.sectionSpacing,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Column(
                        spacing: vars.sectionSpacing,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            spacing: vars.sectionSpacing,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FirstNumberSection(key: firstNumberKey),
                              SecondNumberSection(key: secondNumberKey),
                            ],
                          ),
                          InstructionWidget(key: instructionKey),
                        ],
                      ),
                    ),
                    OutputWidget(key: outputKey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
