import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_monitoring.dart';
import 'ui/features/login/signin_screen.dart';

void main() {
  Bloc.observer = const BlocMonitor();
  OpenAI.apiKey = const String.fromEnvironment('OPENAI_KEY');
  runApp(const WorterApp());
}

class WorterApp extends StatelessWidget {
  const WorterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xff3A37D2),
          onBackground: Colors.white,
        ),
      ),
      home: const SignInScreen(),
    );
  }
}
