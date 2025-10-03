import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditNameInputWidget extends GetView<EditProfileController> {
  const EditNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller.firstNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
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
            onChanged: (v) => controller.clearError(),
          ),
        ),
        const SizedBox(width: mediumSpace),
        Expanded(
          child: TextFormField(
            controller: controller.secondNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Second Name (Optional)',
              hintText: 'Enter your second name',
            ),
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  value.trim().length < 2) {
                return 'Second name must be at least 2 characters';
              }
              return null;
            },
            onChanged: (value) => controller.clearError(),
          ),
        ),
      ],
    );
  }
}
