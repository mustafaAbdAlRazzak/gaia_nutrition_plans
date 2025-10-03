import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:get/get.dart';

class LoginButtonWidget extends GetView<LoginController> {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.isLoading ? null : controller.login,
      child: controller.isLoading
          ? const CircularProgressIndicator()
          : const Text('Login'),
    );
  }
}
