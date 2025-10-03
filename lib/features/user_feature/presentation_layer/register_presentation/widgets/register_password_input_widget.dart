import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/state_manager.dart';

class RegisterPasswordInputWidget extends GetView<RegisterController> {
  final String labelText;
  final String hintText;

  const RegisterPasswordInputWidget({
    super.key,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock_outline, size: 24),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible
                ? Icons.visibility_off
                : Icons.visibility,
            size: 24,
          ),
          onPressed: controller.togglePasswordVisibility,
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
      onChanged: (value) => controller.clearError(),
    );
  }
}
