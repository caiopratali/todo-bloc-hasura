import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_list/src/app.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(App());
}
