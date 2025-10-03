import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditGenderBirthDayWidget extends GetView<EditProfileController> {
  const EditGenderBirthDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) {
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  hintText: 'Male/Female',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                readOnly: true,
                onTap: () => controller.showGenderDialog(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gender';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: mediumSpace),
            Expanded(
              child: TextFormField(
                controller: controller.birthdayController,
                decoration: const InputDecoration(
                  labelText: 'Birthday',
                  hintText: 'DD/MM/YYYY',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => controller.selectDate(context),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value == 'Select Birthday') {
                    return 'Please select birthday';
                  }
                  return null;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
