import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worter/ui/features/login/signin_cubit.dart';
import '../main/main_screen_view.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24,
          ),
          child: BlocProvider<SignInCubit>(
            create: (_) => SignInCubit(),
            child: const MainScreenView(),
          ),
        ),
      ),
    );
  }
}
