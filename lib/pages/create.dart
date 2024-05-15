import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:puzzle_app/modules/puzzle.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String _selectedPuzzle = 'maze';
  bool _showSolution = false;
  Image? _unsolved;
  Image? _solved;

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

  Future<void> _generatePuzzle() async {
    http.Response res = await http
        .get(Uri.parse('http://127.0.0.1:8080/$_selectedPuzzle?width=50'));

    if (res.statusCode == 200) {
      var Puzzle(:unsolved, :solved) = Puzzle.fromJson(jsonDecode(res.body));

      setState(() {
        _showSolution = false;
        _unsolved = Image.network(
            'https://puzzles-db.j164.workers.dev/api/images/?key=$unsolved');
        _solved = Image.network(
            'https://puzzles-db.j164.workers.dev/api/images/?key=$solved');
      });
    } else {
      throw Exception('Failed to fetch puzzle');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double imageSize = min(screenHeight, screenWidth) * 0.6;

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Create a puzzle",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Puzzle Type:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 10),
            DropdownButton(items: const [
              DropdownMenuItem(value: 'maze', child: Text('Maze')),
              // DropdownMenuItem(value: 'nonogram', child: Text('Nonogram')),
              // DropdownMenuItem(value: 'sudoku', child: Text('Sudoku')),
            ], value: _selectedPuzzle, onChanged: _puzzleSelectCallback)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: _showSolution ? _solved : _unsolved,
            ),
          ],
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: _generatePuzzle,
              child: const Text(
                "Create",
                style: TextStyle(fontSize: 20),
              )),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: _unsolved is Image ? _toggleSolution : null,
              child: Text(
                _showSolution ? "Hide Solution" : "Show Solution",
                style: const TextStyle(fontSize: 20),
              )),
        ]),
      ],
    )));
  }
}
