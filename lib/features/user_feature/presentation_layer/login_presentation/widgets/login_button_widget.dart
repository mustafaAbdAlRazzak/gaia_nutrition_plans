import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:get/get.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return ElevatedButton(
          onPressed: controller.isLoading ? null : controller.login,
          child: controller.isLoading
              ? const CircularProgressIndicator()
              : const Text('Login'),
        );
      },
    );
  }
}
