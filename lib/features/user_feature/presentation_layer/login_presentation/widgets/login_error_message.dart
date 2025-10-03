import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:get/get.dart';

class LoginErrorMessage extends GetView<LoginController> {
  const LoginErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            controller.errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
