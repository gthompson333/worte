part of 'signin_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.userName = "",
    this.nameFormField = const NameFormField.unvalidated(),
    this.signInStatus = SignInStatus.initial,
  });

  final NameFormField nameFormField;
  final SignInStatus signInStatus;
  final String userName;

  SignInState copyWith({
    required String userName,
    required NameFormField nameFormField,
    required SignInStatus signInStatus,
  }) {
    return SignInState(
      userName: userName,
      nameFormField: nameFormField,
      signInStatus: signInStatus,
    );
  }

  @override
  List<Object?> get props => [
        nameFormField,
        signInStatus,
      ];
}

enum SignInStatus {
  initial,
  validName,
  invalidName,
}
