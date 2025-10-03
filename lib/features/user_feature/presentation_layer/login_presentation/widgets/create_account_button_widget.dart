import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:get/state_manager.dart';

class CreateAccountButtonWidget extends GetView<LoginController> {
  const CreateAccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: controller.goToCreateAccountPage,
      child: const Text('Create Account'),
    );
  }
}
