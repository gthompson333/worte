import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'name_formfield.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit()
      : super(
          const SignInState(),
        );

  /// Called when the name formfield value changes.
  void onNameChanged(String newValue) {
    final previousScreenState = state;
    final previousNameFormField = previousScreenState.nameFormField;
    final shouldValidate = previousNameFormField.isNotValid;
    final newNameFormField = shouldValidate
        ? NameFormField.validated(
            newValue,
          )
        : NameFormField.unvalidated(
            newValue,
          );

    final newState = state.copyWith(
      userName: newValue,
      nameFormField: newNameFormField,
      signInStatus: newNameFormField.isValid
          ? SignInStatus.validName
          : SignInStatus.invalidName,
    );

    emit(newState);
  }

  /// Called when the focus is removed from the name formfield.
  void onNameUnfocused() {
    final previousScreenState = state;
    final previousNameFormField = previousScreenState.nameFormField;
    final previousNameValue = previousNameFormField.value;

    final newNameFormField = NameFormField.validated(
      previousNameValue,
    );

    final newState = state.copyWith(
      userName: previousNameValue,
      nameFormField: newNameFormField,
      signInStatus: newNameFormField.isValid
          ? SignInStatus.validName
          : SignInStatus.invalidName,
    );

    emit(newState);
  }

  /// Called when the sign-in screen submission has been executed.
  void onSubmit() async {
    final newNameFormField = NameFormField.validated(state.nameFormField.value);

    final newState = state.copyWith(
      userName: newNameFormField.value,
      nameFormField: newNameFormField,
      signInStatus: newNameFormField.isValid
          ? SignInStatus.validName
          : SignInStatus.invalidName,
    );

    emit(newState);
  }
}
