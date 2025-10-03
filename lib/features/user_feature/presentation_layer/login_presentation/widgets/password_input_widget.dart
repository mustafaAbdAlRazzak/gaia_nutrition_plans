import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:get/state_manager.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return TextFormField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () => controller.togglePasswordVisibility(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (value) => controller.clearError(),
        );
      },
    );
  }
}
