import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worter/ui/features/login/signin_cubit.dart';
import 'main_screen.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  bool userNameValid = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextField(
                autocorrect: false,
                onChanged: cubit.onNameChanged,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter a name',
                ),
              ),
            ),
            BlocConsumer<SignInCubit, SignInState>(
              listener: (context, state) {
                userNameValid = state.signInStatus == SignInStatus.validName;
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: userNameValid
                      ? () => {
                            Navigator.push(context, MainScreen.route('')),
                          }
                      : null,
                  child: const Text('Lass Uns Gehen!'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
