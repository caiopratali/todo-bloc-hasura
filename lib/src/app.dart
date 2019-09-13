import 'package:flutter/material.dart';
import 'package:todo_list/src/ui/todo_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}
