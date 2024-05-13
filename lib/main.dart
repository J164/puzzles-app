import 'package:flutter/material.dart';

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

enum Puzzle {
  maze,
  nonogram,
  sudoku
}

class _MyHomePageState extends State<MyHomePage> {
  Puzzle _selectedPuzzle = Puzzle.maze;

  void puzzleSelectCallback(Object? selectedPuzzle) {
    if (selectedPuzzle is Puzzle) {
      setState(() {
        _selectedPuzzle = selectedPuzzle;
      });
    }
  }

  void _generatePuzzle() {
    setState(() {
      print(_selectedPuzzle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Puzzle Type:',
            ),
            DropdownButton(items: const [
              DropdownMenuItem(value: Puzzle.maze, child: Text('Maze')),
              DropdownMenuItem(value: Puzzle.nonogram, child: Text('Nonogram')),
              DropdownMenuItem(value: Puzzle.sudoku, child: Text('Sudoku')),
            ], 
            value: _selectedPuzzle,
            onChanged: puzzleSelectCallback)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generatePuzzle,
        tooltip: 'Generate',
        child: const Icon(Icons.add),
      ),
    );
  }
}
