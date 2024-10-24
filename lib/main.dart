import 'package:flutter/material.dart';
import 'views/task_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App (MVP)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskViewPage(),
    );
  }
}
