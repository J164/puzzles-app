import 'package:flutter/material.dart';
import 'package:puzzle_app/ui/form.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Create a puzzle",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0), child: PuzzleForm())
        ],
      )),
    ));
  }
}
