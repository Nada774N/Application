import 'package:flutter/material.dart';

class ArchivedTaskScreen extends StatefulWidget {
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedTaskScreen> createState() => _ArchivedTaskScreenState();
}

class _ArchivedTaskScreenState extends State<ArchivedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Text(
          'New Task',
          style:TextStyle(
          fontWeight: FontWeight.bold,
      ),),
    );
  }
}
