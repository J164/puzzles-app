import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PuzzleForm extends StatefulWidget {
  const PuzzleForm({super.key});

  @override
  PuzzleFormState createState() {
    return PuzzleFormState();
  }
}

class PuzzleFormState extends State<PuzzleForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedPuzzle = 'maze';

  bool _showSolution = false;
  Uint8List? _unsolved;
  Uint8List? _solved;

  // Maze
  int? _width;
  int? _height;

  void _puzzleSelectCallback(Object? selectedPuzzle) {
    if (selectedPuzzle is String) {
      setState(() {
        _selectedPuzzle = selectedPuzzle;
      });
    }
  }

  void _toggleSolution() {
    setState(() {
      _showSolution = !_showSolution;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Uri? uri;
      switch (_selectedPuzzle) {
        case 'maze':
          {
            uri = Uri.parse(_height != null
                ? 'http://127.0.0.1:8080/maze?width=$_width&height=$_height'
                : 'http://127.0.0.1:8080/maze?width=$_width');
          }
      }

      http.Response res = await http.get(uri!);

      if (res.statusCode == 200) {
        setState(() {
          _showSolution = false;
          _unsolved = res.bodyBytes;
        });
      } else {
        throw Exception('Failed to fetch puzzle');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> fields = {
      "maze": Row(children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: "Width"),
            validator: (value) {
              if (value == null) {
                return 'Please enter a value';
              }

              var number = int.tryParse(value);

              if (number == null || number < 1 || number > 100) {
                return 'Please enter a valid integer (1-100)';
              }

              return null;
            },
            onSaved: (value) => _width = int.parse(value!),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: "Height"),
            validator: (value) {
              if (value == null) {
                return null;
              }

              var number = int.tryParse(value);

              if (number == null || number < 1 || number > 100) {
                return 'Please enter a valid integer (1-100)';
              }

              return null;
            },
            onSaved: (value) => {
              if (value != null) {_height = int.parse(value)}
            },
          ),
        ),
      ]),
    };

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Puzzle Type:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'maze', child: Text('Maze')),
                    // DropdownMenuItem(value: 'nonogram', child: Text('Nonogram')),
                    // DropdownMenuItem(value: 'sudoku', child: Text('Sudoku')),
                  ],
                  value: _selectedPuzzle,
                  onChanged: _puzzleSelectCallback,
                ),
              )
            ]),
            const SizedBox(height: 30),
            fields[_selectedPuzzle]!,
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Create", style: TextStyle(fontSize: 20))),
            const SizedBox(height: 20),
            Container(
              child: _unsolved != null
                  ? Image.memory(_showSolution ? _solved! : _unsolved!)
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _unsolved is Image ? _toggleSolution : null,
                child: Text(
                  _showSolution ? "Hide Solution" : "Show Solution",
                  style: const TextStyle(fontSize: 20),
                )),
          ],
        ));
  }
}
