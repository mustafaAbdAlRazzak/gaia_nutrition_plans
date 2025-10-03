import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SecondNameInputWidget extends GetView<RegisterController> {
  const SecondNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.secondNameController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Second Name (Optional)',
        hintText: 'Enter your second name',
        prefixIcon: Icon(Icons.person_outline, size: 24),
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty && value.trim().length < 2) {
          return 'Second name must be at least 2 characters';
        }
        return null;
      },
      onChanged: (value) => controller.clearError(),
    );
  }
}
