import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/app.dart';
import 'app/core/dependencies/inject_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InjectDependencies.init();
  runApp(const App());
}
