import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supabase_project/Pages/notesPage.dart';
import 'package:supabase_project/Pages/uploadPage.dart';

void main() async {
  //*step1
  //supabase Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2Y2pncGliZXlzcGhwc3VqaHhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5MzEwNjYsImV4cCI6MjA2MzUwNzA2Nn0.KLKaOGvnqy4WRzY6jEmnMREhlUPO0uDP-BZVm4zr9UY",
      url: "https://vvcjgpibeysphpsujhxs.supabase.co");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Supabase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Uploadpage());
  }
}
