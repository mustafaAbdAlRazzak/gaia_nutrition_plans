import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/get.dart';

class RegisterErorrWidget extends GetView<RegisterController> {
  const RegisterErorrWidget({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.error_outline, color: Colors.red, size: mediumIcon),
      const SizedBox(width: smallSpace),
      Expanded(
        child: Text(
          controller.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    ],
  );
}
