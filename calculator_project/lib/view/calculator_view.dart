import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  int? first;
  int? second;
  String operation = "";
  String history = "";

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        _textController.text = "";
        first = null;
        second = null;
        operation = "";
        history = "";
      } else if (symbol == "<-") {
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (symbol == "=" && operation.isNotEmpty) {
        second = int.tryParse(_textController.text);
        if (second != null) {
          int result = 0;
          if (operation == "+") {
            result = (first ?? 0) + second!;
          } else if (operation == "-") {
            result = (first ?? 0) - second!;
          } else if (operation == "*") {
            result = (first ?? 0) * second!;
          } else if (operation == "/") {
            result = second != 0 ? (first ?? 0) ~/ second! : 0;
          }
          history += " ${second!} =";
          _textController.text = result.toString();
          first = result;
          second = null;
          operation = "";
        }
      } else if (["+", "-", "*", "/"].contains(symbol)) {
        if (_textController.text.isNotEmpty) {
          first = int.tryParse(_textController.text);
          if (first != null) {
            operation = symbol;
            history = "$first $operation";
            _textController.text = "";
          }
        }
      } else {
        // Append numbers or dot
        _textController.text += symbol;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('khushbu_Calculator App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              // History display
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  history,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Main display
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
