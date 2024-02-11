import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    required this.icons,
    required this.hintText,
    required this.validatorString,
    required this.keyboardType,
    required this.emailController,
    super.key,
  });

  final TextEditingController emailController;
  final String validatorString;
  final IconData icons;
  final String hintText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: keyboardType == TextInputType.visiblePassword ? true : false,
      keyboardType: keyboardType,
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(icons),
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorString;
        }
        return null;
      },
    );
  }
}
