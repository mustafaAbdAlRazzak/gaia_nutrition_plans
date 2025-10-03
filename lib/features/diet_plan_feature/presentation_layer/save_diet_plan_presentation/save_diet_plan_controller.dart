import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/create_diet_plan_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/update_diet_plan_use_case.dart';
import 'package:get/get.dart';

class SaveDietPlanController extends GetxController {
  final CreateDietPlanUseCase createDietPlanUseCase;
  final UpdateDietPlanUseCase updateDietPlanUseCase;
  final DietPlanEntity? currentDietPlan;

  SaveDietPlanController({
    required this.createDietPlanUseCase,
    required this.updateDietPlanUseCase,
    this.currentDietPlan,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();

  bool isEditMode = false;
  bool isLoading = false;

  @override
  void onInit() {
    if (currentDietPlan != null) {
      isEditMode = true;
      nameController.text = currentDietPlan!.name;
      descriptionController.text = currentDietPlan!.description;
    }
    nameFocusNode.requestFocus();
    super.onInit();
  }

  void onNameFieldSubmitted(String value) {
    descriptionFocusNode.requestFocus();
  }

  Future<void> saveDietPlan() async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    update();
    final dietPlan = DietPlanEntity(
      id: currentDietPlan?.id,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
    );
    try {
      if (isEditMode) {
        await updateDietPlanUseCase.execute(dietPlan);
      } else {
        await createDietPlanUseCase.execute(dietPlan);
      }
      Get.back(result: true);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save diet plan',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    nameFocusNode.dispose();
    descriptionController.dispose();
    descriptionFocusNode.dispose();
    super.onClose();
  }

  void onCancel() => Get.back(result: false);
}
