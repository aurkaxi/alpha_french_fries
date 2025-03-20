import 'package:alpha_french_fries/operation.dart';
import 'package:alpha_french_fries/vars.dart' as vars;
import 'package:fluent_ui/fluent_ui.dart';

class OperationSection extends StatefulWidget {
  const OperationSection({super.key});

  @override
  State<OperationSection> createState() => OperationSectionState();
}

class OperationSectionState extends State<OperationSection> {
  Operation _selectedOperation = Operation.addition;
  void setOp(Operation operation) {
    setState(() {
      _selectedOperation = operation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        spacing: vars.itemSpacing,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButton(
            checked: _selectedOperation == Operation.addition,
            child: Text("Addition"),
            onChanged: (state) => state ? setOp(Operation.addition) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.negation,
            child: Text("Negation"),
            onChanged: (state) => state ? setOp(Operation.negation) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.and,
            child: Text("AND"),
            onChanged: (state) => state ? setOp(Operation.and) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.or,
            child: Text("OR"),
            onChanged: (state) => state ? setOp(Operation.or) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.leftShift,
            child: Text("Left Shift"),
            onChanged: (state) => state ? setOp(Operation.leftShift) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.subtraction,
            child: Text("Subtraction"),
            onChanged: (state) => state ? setOp(Operation.subtraction) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.rightShift,
            child: Text("Right Shift"),
            onChanged: (state) => state ? setOp(Operation.rightShift) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.increment,
            child: Text("Increment"),
            onChanged: (state) => state ? setOp(Operation.increment) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.decrement,
            child: Text("Decrement"),
            onChanged: (state) => state ? setOp(Operation.decrement) : null,
          ),
          ToggleButton(
            checked: _selectedOperation == Operation.xor,
            child: Text("XOR"),
            onChanged: (state) => state ? setOp(Operation.xor) : null,
          ),
        ],
      ),
    );
  }
}
