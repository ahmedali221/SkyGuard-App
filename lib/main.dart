import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // a new comment
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
