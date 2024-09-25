import 'package:formz/formz.dart';

// Define input validation errors es personalizado yp lo defino
enum EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Email.dirty(super.value) : super.dirty();
  //const Username.dirty( String value) : super.dirty(value );

//* getter que me mandara el error que tiene el input
  String? get errorMessage {
    if (isValid || isPure) return null;

//*displayError es una propiedad que ofrece Formz para verificar los errores
    if (displayError == EmailError.empty) return 'El campo es requerido';
    if (displayError == EmailError.format) {
      return 'Ingrese un correo electronico valido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;

    if (!emailRegExp.hasMatch(value)) return EmailError.format;

    return null;
  }
}
