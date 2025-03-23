import 'package:alpha_french_fries/alu_model.dart';
import 'package:alpha_french_fries/alu_notifier.dart';
import 'package:alpha_french_fries/bt_model.dart';
import 'package:alpha_french_fries/bt_service.dart';
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
  late final ALUNotifier aluNotifier;
  late final BTService bluetoothService;

  @override
  void initState() {
    super.initState();
    aluNotifier = ALUNotifier(ALUModel());
    bluetoothService = BTService(BTModel());
  }

  @override
  void dispose() {
    bluetoothService.dispose();
    aluNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: FluentThemeData(brightness: Brightness.light),
      darkTheme: FluentThemeData(brightness: Brightness.dark),

      home: ScaffoldPage(
        bottomBar: ValueListenableBuilder(
          valueListenable: bluetoothService,
          builder: (_, value, _) {
            return Text(value.status, textAlign: TextAlign.start);
          },
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
          child: Column(
            spacing: vars.sectionSpacing,
            children: [
              OperationSection(aluNotifier: aluNotifier),
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
                              FirstNumberSection(aluNotifier: aluNotifier),
                              SecondNumberSection(aluNotifier: aluNotifier),
                            ],
                          ),
                          InstructionWidget(
                            aluNotifier: aluNotifier,
                            bluetoothService: bluetoothService,
                          ),
                        ],
                      ),
                    ),
                    OutputWidget(
                      aluNotifier: aluNotifier,
                      bluetoothService: bluetoothService,
                    ),
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
