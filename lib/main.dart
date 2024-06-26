import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worter/ui/features/login/signin_cubit.dart';
import 'package:worter/ui/features/main/word_bloc.dart';
import 'package:worter/ui/features/main/hint_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInCubit(),
        ),
        BlocProvider(
          create: (_) => WordBloc(),
        ),
        BlocProvider(
          create: (_) => HintBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Deutsch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.yellow,
            background: Colors.black,
          ),
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
