import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/app/di/dependecy_injection.dart';
import 'package:storeapp/app/main_app.dart';
import 'package:storeapp/firebase_options.dart';

void main() async {
  DependencyInjection.setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}
