import 'dart:convert';

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
        'solved': List<dynamic> solved,
        'unsolved': List<dynamic> unsolved,
      } =>
        Puzzle(
          unsolved: unsolved[0],
          solved: solved[0],
        ),
      _ => throw const FormatException('Failed to load puzzle'),
    };
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedPuzzle = 'maze';
  Image _unsolved = const Image(image: AssetImage("assets/missing.png"));
  Image _solved = const Image(image: AssetImage("assets/missing.png"));

  void _puzzleSelectCallback(Object? selectedPuzzle) {
    if (selectedPuzzle is String) {
      setState(() {
        _selectedPuzzle = selectedPuzzle;
      });
    }
  }

  Future<http.Response> _fetchPuzzle() {
    return http
        .get(Uri.parse('http://127.0.0.1:3000/$_selectedPuzzle?width=10'));
  }

  Future<void> _generatePuzzle() async {
    http.Response res = await _fetchPuzzle();

    if (res.statusCode == 200) {
      Puzzle puzzle = Puzzle.fromJson(jsonDecode(res.body));

      setState(() {
        _unsolved = Image.network(puzzle.unsolved);
        _solved = Image.network(puzzle.solved);
      });
    } else {
      throw Exception('Failed to fetch puzzle');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Puzzle Type:',
            ),
            DropdownButton(items: const [
              DropdownMenuItem(value: 'maze', child: Text('Maze')),
              // DropdownMenuItem(value: 'nonogram', child: Text('Nonogram')),
              // DropdownMenuItem(value: 'sudoku', child: Text('Sudoku')),
            ], value: _selectedPuzzle, onChanged: _puzzleSelectCallback)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_unsolved, _solved],
        )
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _generatePuzzle,
        tooltip: 'Generate',
        child: const Icon(Icons.add),
      ),
    );
  }
}
