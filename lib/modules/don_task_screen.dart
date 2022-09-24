import 'package:flutter/material.dart';

class DoneTaskScreen extends StatefulWidget {
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
          'Done Task',
          style:TextStyle(
          fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}
