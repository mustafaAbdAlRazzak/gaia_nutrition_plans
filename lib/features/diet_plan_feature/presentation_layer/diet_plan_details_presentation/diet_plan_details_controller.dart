import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_diet_plan_meal_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_calories_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_carbohydrate_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_fat_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_protein_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/delete_meal_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_binding.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_page.dart';
import 'package:gaia_nutrition_plans/shared_widgets/confirm_deletion_dialog.dart';
import 'package:get/get.dart';

class DietPlanDetailsController extends GetxController {
  final DietPlanEntity dietPlan;
  final GetDietPlanMealUseCase getDietPlanMealUseCase;
  final GetTotalCarbohydrateUseCase getTotalCarbohydrateUseCase;
  final GetTotalFatUseCase getTotalFatUseCase;
  final GetTotalProteinUseCase getTotalProteinUseCase;
  final GetTotalCaloriesUseCase getTotalCaloriesUseCase;
  final DeleteMealUseCase deleteMealUseCase;

  DietPlanDetailsController({
    required this.dietPlan,
    required this.getDietPlanMealUseCase,
    required this.getTotalCarbohydrateUseCase,
    required this.getTotalFatUseCase,
    required this.getTotalProteinUseCase,
    required this.getTotalCaloriesUseCase,
    required this.deleteMealUseCase,
  });

  List<MealEntity> meals = [];
  double totalCalories = 0.0;
  double totalProtein = 0.0;
  double totalFat = 0.0;
  double totalCarbohydrate = 0.0;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading = true;
      update();
      meals = await getDietPlanMealUseCase.execute(dietPlan);
      await loadNutritionalInfo();
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to load diet plan details: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> loadNutritionalInfo() async {
    try {
      totalCalories = await getTotalCaloriesUseCase.execute(dietPlan);
      totalProtein = await getTotalProteinUseCase.execute(dietPlan);
      totalFat = await getTotalFatUseCase.execute(dietPlan);
      totalCarbohydrate = await getTotalCarbohydrateUseCase.execute(dietPlan);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error loading nutritional info: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> addMeal() async {
    final bool? result = await Get.to(
      () => const CreateMealPage(),
      binding: CreateMealBinding(dietPlanId: dietPlan.id!),
    );
    if (result != null && result == true) {
      await loadData();
    }
  }

  Future<void> editMeal(MealEntity meal) async {
    final bool? result = await Get.to(
      () => const CreateMealPage(),
      binding: CreateMealBinding(dietPlanId: dietPlan.id!, meal: meal),
    );
    if (result != null && result == true) {
      await loadData();
    }
  }

  Future<void> deleteMeal(MealEntity meal) async {
    openConfirmDeletionDialog(() async {
      await deleteMealUseCase.execute(meal);
      await loadData();
      Get.back();
    });
  }

  Future<void> refreshData() async {
    await loadData();
  }
}
