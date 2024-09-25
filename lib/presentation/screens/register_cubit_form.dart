import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';

import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterCubitForm extends StatelessWidget {
  const RegisterCubitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: BlocProvider(
        create: (_) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //*Cuando se tenga un widget que contenga un TextFormField siempre debemos envolverlo en un "SingleChildScrollView"
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(size: 100),
              _RegisterForm(),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            CustomFormfield(
              label: 'Nombre de usuario',
              onChanged: registerCubit.usernameChange,
              errorMessage: username.errorMessage,
              icon: Icon(
                Icons.supervised_user_circle_outlined,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 15),
            CustomFormfield(
              label: 'correo electronico',
              onChanged: registerCubit.emailChange,
              errorMessage: email.errorMessage,
              icon: Icon(
                Icons.alternate_email,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 15),
            CustomFormfield(
              label: 'Contraseña',
              onChanged: registerCubit.passwordChange,
              errorMessage: password.errorMessage,
              icon: Icon(
                Icons.password_outlined,
                color: colors.primary,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
                onPressed: () {
                  registerCubit.onSumit();
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}
