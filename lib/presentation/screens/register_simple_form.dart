import 'package:flutter/material.dart';

import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterSimpleForm extends StatelessWidget {
  const RegisterSimpleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: const _RegisterView(),
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            CustomFormfield(
                label: 'Nombre de usuario',
                onChanged: (value) => username = value,
                icon: Icon(
                  Icons.supervised_user_circle_outlined,
                  color: colors.primary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo requerido';
                  } else if (value.trim().isEmpty) {
                    return 'campo requerido';
                  } else if (value.length < 6) {
                    return 'el nombre debe ser mayor a 6 letras';
                  }

                  return null;
                }),
            const SizedBox(height: 15),
            CustomFormfield(
                label: 'correo electronico',
                onChanged: (value) => email = value,
                icon: Icon(
                  Icons.alternate_email,
                  color: colors.primary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo requerido';
                  } else if (value.trim().isEmpty) {
                    return 'campo requerido';
                  }

                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegExp.hasMatch(value)) {
                    return 'Ingrese un correo valido';
                  }

                  return null;
                }),
            const SizedBox(height: 15),
            CustomFormfield(
                label: 'Contraseña',
                onChanged: (value) => password = value,
                icon: Icon(
                  Icons.password_outlined,
                  color: colors.primary,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo requerido';
                  } else if (value.trim().isEmpty) {
                    return 'campo requerido';
                  } else if (value.length < 6) {
                    return 'la contraseña debe ser mayor a 6 caracteres';
                  }

                  return null;
                }),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();

                  if (!isValid) return;

                  print('$username, $email, $password');
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}
