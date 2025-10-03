import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/widgets/diet_plan_description_field.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/widgets/diet_plan_name_field.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/widgets/save_diet_plan_actions.dart';
import 'package:get/get.dart';

class SaveDietPlanDialog extends GetView<SaveDietPlanController> {
  const SaveDietPlanDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.isEditMode ? 'Edit Diet Plan' : 'Create Diet Plan',
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: controller.onCancel,
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: const SafeArea(
          child: Column(
            children: [
              DietPlanNameField(),
              SizedBox(height: mediumSpace),
              DietPlanDescriptionField(),
              SizedBox(height: mediumSpace),
              SaveDietPlanActions(),
            ],
          ),
        ),
      ),
    );
  }
}
