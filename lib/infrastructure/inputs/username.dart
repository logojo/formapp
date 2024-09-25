import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty(super.value) : super.dirty();
  //const Username.dirty( String value) : super.dirty(value );

//* getter que me mandara el error que tiene el input
  String? get errorMessage {
    if (isValid || isPure) return null;

//*displayError es una propiedad que ofrece Formz para verificar los errores
    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.length) {
      return 'El nombre debe contener minimo 6 caracteres';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsernameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.length < 6) return UsernameError.length;

    return null;
  }
}
