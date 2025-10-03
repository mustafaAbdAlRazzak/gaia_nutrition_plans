import 'package:flutter/material.dart';

class RegisterPasswordInputWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final void Function() toggleVisibility;
  final Function clearError;
  final bool isVisible;

  const RegisterPasswordInputWidget({
    super.key,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
    required this.controller,
    required this.toggleVisibility,
    required this.clearError,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock_outline, size: 24),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility_off : Icons.visibility,
            size: 24,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          return 'Password must contain uppercase, lowercase and number';
        }
        return null;
      },
      onChanged: (value) => clearError(),
    );
  }
}
