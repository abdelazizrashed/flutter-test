import 'package:evaluation_project/app.dart';
import 'package:evaluation_project/domain/local/shared_prefs.dart';
import 'package:evaluation_project/service_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await sharedPrefInit();
  runApp(const App());
}
