import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

enum NameValidationError { empty, tooShort }

class NameFormField extends FormzInput<String, NameValidationError>
    with EquatableMixin {
  const NameFormField.unvalidated([String value = '']) : super.pure(value);

  const NameFormField.validated([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    }
    if (value.length < 3) {
      return NameValidationError.tooShort;
    }
    return null;
  }

  @override
  List<Object?> get props => [value];
}
