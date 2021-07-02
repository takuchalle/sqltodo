import 'package:flutter/material.dart';
import 'app.dart';
import 'db.dart';
import 'entities/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.open();
  runApp(const App());
}
