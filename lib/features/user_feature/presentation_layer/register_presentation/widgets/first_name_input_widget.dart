import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/get.dart';

class FirstNameInputWidget extends GetView<RegisterController> {
  const FirstNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.firstNameController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'First Name',
        hintText: 'Enter your first name',
        prefixIcon: Icon(Icons.person_outline, size: 24),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your first name';
        }
        if (value.trim().length < 2) {
          return 'First name must be at least 2 characters';
        }
        return null;
      },
      onChanged: (value) => controller.clearError(),
    );
  }
}
