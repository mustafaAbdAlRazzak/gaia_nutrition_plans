import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/get.dart';

class RegisterEmailInputWidget extends GetView<RegisterController> {
  const RegisterEmailInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email address',
        prefixIcon: Icon(Icons.email_outlined, size: 24),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onChanged: (value) => controller.clearError(),
    );
  }
}
