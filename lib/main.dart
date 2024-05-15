import 'package:flutter/material.dart';
import 'package:puzzle_app/pages/create.dart';
import 'package:puzzle_app/pages/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Container(),
    );
  }
}

class Container extends StatefulWidget {
  const Container({super.key});

  @override
  State<Container> createState() => _ContainerState();
}

class _ContainerState extends State<Container> {
  int index = 0;
  final pages = [const HomePage(), const CreatePage()];

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Puzzle App'),
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() {
          this.index = index;
        }),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Create'),
        ],
      ));
}
