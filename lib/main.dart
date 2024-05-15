import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Puzzle App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Puzzle {
  final String unsolved;
  final String solved;

  const Puzzle({
    required this.unsolved,
    required this.solved,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'solved': String solved,
        'unsolved': String unsolved,
      } =>
        Puzzle(
          unsolved: unsolved,
          solved: solved,
        ),
      _ => throw const FormatException('Failed to load puzzle'),
    };
  }
}

class _MyHomePageState extends State<MyHomePage> {
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

  Future<http.Response> _fetchPuzzle() {
    return http
        .get(Uri.parse('http://127.0.0.1:8080/$_selectedPuzzle?width=50'));
  }

  Future<void> _generatePuzzle() async {
    http.Response res = await _fetchPuzzle();

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Generate a puzzle",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: _generatePuzzle,
                  child: const Text(
                    "Generate Puzzle",
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(
                width: 20,
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
