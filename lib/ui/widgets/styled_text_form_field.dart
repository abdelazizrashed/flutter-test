import 'package:flutter/material.dart';

class StyledTextFormField extends StatelessWidget {
  const StyledTextFormField({
    Key? key,
    required this.phoneController,
    required this.label,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController phoneController;
  final String label;
  final String? Function(String? value)? validator;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
