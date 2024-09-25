import 'package:flutter/material.dart';

class CustomFormfield extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool obscureText;

  const CustomFormfield(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChanged,
      this.validator,
      this.icon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      //borderSide: BorderSide(color: colors.primary)
    );

    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        isDense: true,
        label: Text('$label'),
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: icon,
        errorText: errorMessage, //'Este es el error text'

        //*este icono va al final
        // suffixIcon: Icon(
        //   Icons.supervised_user_circle_outlined,
        //   color: colors.primary,
        // )
      ),
    );
  }
}
