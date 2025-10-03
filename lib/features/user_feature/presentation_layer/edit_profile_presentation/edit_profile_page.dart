import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_controller.dart';
import 'package:get/get.dart';
import 'widgets/edit_name_input_widget.dart';
import 'widgets/edit_gender_birthday_widget.dart';
import 'widgets/edit_weight_height_input_widget.dart';
import 'widgets/edit_profile_loading_widget.dart';
import 'widgets/edit_profile_error_widget.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.isLoading ? null : controller.updateProfile,
            child: const Text('Save'),
          ),
        ],
      ),
      body: GetBuilder<EditProfileController>(
        builder: (controller) {
          if (controller.isInitialLoading) {
            return const EditProfileLoadingWidget();
          }
          if (controller.errorMessage != null) {
            return const EditProfileErrorWidget();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(mediumSpace),
            child: Form(
              key: controller.formKey,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditNameInputWidget(),
                  SizedBox(height: mediumSpace),
                  EditGenderBirthDayWidget(),
                  SizedBox(height: mediumSpace),
                  EditWeightHeightInputWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
