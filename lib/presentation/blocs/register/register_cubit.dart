import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSumit() {
    //* cambiando el estado para verificar si el formulario es valido
    emit(state.copyWith(
        formStatus: FormStatus.valid,
        username: Username.dirty(state.username.value),
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),
        isValid:
            Formz.validate([state.username, state.password, state.email])));

    print('Submit $state');
  }

  void usernameChange(String value) {
    final username = Username.dirty(value);

    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.email, state.password])));
  }

  void emailChange(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.username,
        ])));
  }

  void passwordChange(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([
          password,
          state.username,
          state.email,
        ])));
  }
}
