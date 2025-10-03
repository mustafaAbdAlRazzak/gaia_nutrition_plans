import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/create_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/delete_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/update_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/create_meal_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_ingredients_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/update_meal_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/select_foods_presentation/select_foods_binding.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/select_foods_presentation/select_foods_page.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_food_form_local_data_base_by_id_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/save_food_use_case.dart';
import 'package:get/get.dart';

class SelectedFood {
  final int? mealIngredientId;
  final int foodId;
  final String name;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double calories;
  final TextEditingController weightController = TextEditingController(
    text: '100.0',
  );

  SelectedFood({
    required this.foodId,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.calories,
    this.mealIngredientId,
  });
  double get weight => double.tryParse(weightController.text) ?? 0;
  double get calculatedProtein => (protein * weight) / 100;
  double get calculatedFat => (fat * weight) / 100;
  double get calculatedCarbohydrate => (carbohydrate * weight) / 100;
  double get calculatedCalories => (calories * weight) / 100;
}

class CreateMealController extends GetxController {
  late final CreateMealUseCase createMealUseCase;
  late final CreateMealIngredientUseCase createMealIngredientUseCase;
  late final SaveFoodUseCase saveFoodUseCase;
  late final GetMealIngredientsUseCase getMealIngredientsUseCase;
  late final GetFoodFormLocalDataBaseByIdUseCase
  getFoodFormLocalDataBaseByIdUseCase;
  late final UpdateMealUseCase updateMealUseCase;
  late final UpdateMealIngredientUseCase updateMealIngredientUseCase;
  late final DeleteMealIngredientUseCase deleteMealIngredientUseCase;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<SelectedFood> selectedFoods = [];
  final List<SelectedFood> deletedFoods = [];
  final MealEntity? meal;
  final int dietPlanId;
  bool isSaving = false;

  CreateMealController({
    required this.createMealUseCase,
    required this.createMealIngredientUseCase,
    required this.saveFoodUseCase,
    required this.getMealIngredientsUseCase,
    required this.getFoodFormLocalDataBaseByIdUseCase,
    required this.updateMealUseCase,
    required this.updateMealIngredientUseCase,
    required this.deleteMealIngredientUseCase,
    required this.dietPlanId,
    this.meal,
  });

  @override
  void onInit() {
    super.onInit();
    init();
  }

  bool isEditMode() => meal != null;

  Future<void> init() async {
    if (meal != null) {
      nameController.text = meal!.name;
      descriptionController.text = meal!.description;
      final List<MealIngredientEntity> mealIngredients =
          await getMealIngredientsUseCase.execute(meal!);
      for (final mealIngredient in mealIngredients) {
        final food = await getFoodFormLocalDataBaseByIdUseCase.execute(
          mealIngredient.foodId!,
        );
        final SelectedFood selectedFood = SelectedFood(
          mealIngredientId: mealIngredient.id,
          foodId: mealIngredient.foodId!,
          name: food.name,
          protein: food.protein,
          fat: food.fat,
          carbohydrate: food.carbohydrate,
          calories: food.calories,
        );
        selectedFood.weightController.text = mealIngredient.weight.toString();
        selectedFoods.add(selectedFood);
      }
      update();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> goToSelectFoodsPage() async {
    final List<FoodEntity> foods =
        await Get.to(
              () => const SelectFoodsPage(),
              binding: SelectFoodsBinding(),
            )
            as List<FoodEntity>;
    for (final food in foods) {
      addFood(food);
    }
  }

  void addFood(FoodEntity food) {
    final existingIndex = selectedFoods.indexWhere(
      (sf) => sf.foodId == food.id,
    );
    if (existingIndex == -1) {
      selectedFoods.add(
        SelectedFood(
          foodId: food.id!,
          name: food.name,
          protein: food.protein,
          fat: food.fat,
          carbohydrate: food.carbohydrate,
          calories: food.calories,
        ),
      );
      update();
    }
  }

  void removeFood(int index) {
    if (isEditMode()) {
      deletedFoods.add(selectedFoods[index]);
    }
    selectedFoods.removeAt(index);
    update();
  }

  double get totalCalories {
    return selectedFoods.fold(
      0.0,
      (sum, food) => sum + food.calculatedCalories,
    );
  }

  double itemCalories(int index) => selectedFoods[index].calculatedCalories;

  double get totalProtein {
    return selectedFoods.fold(0.0, (sum, food) => sum + food.calculatedProtein);
  }

  double itemProtein(int index) => selectedFoods[index].calculatedProtein;

  double get totalFat {
    return selectedFoods.fold(0.0, (sum, food) => sum + food.calculatedFat);
  }

  double itemFat(int index) => selectedFoods[index].calculatedFat;

  double get totalCarbohydrate {
    return selectedFoods.fold(
      0.0,
      (sum, food) => sum + food.calculatedCarbohydrate,
    );
  }

  double itemCarbohydrate(int index) =>
      selectedFoods[index].calculatedCarbohydrate;

  bool get canSave {
    return nameController.text.trim().isNotEmpty &&
        selectedFoods.isNotEmpty &&
        !isSaving;
  }

  Future<void> editMeal() async {
    if (!canSave) return;

    isSaving = true;
    update();

    try {
      await updateMealUseCase.execute(
        MealEntity(
          id: meal!.id,
          dietPlanId: meal!.dietPlanId,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
        ),
      );
      // delete deleted foods
      for (final deletedFood in deletedFoods) {
        await deleteMealIngredientUseCase.execute(
          MealIngredientEntity(
            id: deletedFood.mealIngredientId,
            mealId: meal!.id!,
            weight: deletedFood.weight,
            foodId: deletedFood.foodId,
          ),
        );
      }
      // update meal ingredients
      for (final selectedFood in selectedFoods) {
        final ingredient = MealIngredientEntity(
          id: selectedFood.mealIngredientId,
          mealId: meal!.id!,
          weight: selectedFood.weight,
          foodId: selectedFood.foodId,
        );
        if (ingredient.id == null) {
          await createMealIngredientUseCase.execute(ingredient);
        } else {
          await updateMealIngredientUseCase.execute(ingredient);
        }
      }
      Get.back(result: true);
      Get.snackbar(
        'Success',
        'Meal updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save meal: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving = false;
      update();
    }
  }

  Future<void> createMeal() async {
    if (!canSave) return;

    isSaving = true;
    update();

    try {
      // Create meal entity
      final meal = MealEntity(
        dietPlanId: dietPlanId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
      );

      // Save meal and get the ID
      final mealId = await createMealUseCase.execute(meal);

      // Save meal ingredients
      for (final selectedFood in selectedFoods) {
        final foodEntity = FoodEntity(
          id: selectedFood.foodId,
          name: selectedFood.name,
          protein: selectedFood.protein,
          fat: selectedFood.fat,
          carbohydrate: selectedFood.carbohydrate,
          calories: selectedFood.calories,
        );
        final foodId = await saveFoodUseCase.execute(foodEntity);
        final ingredient = MealIngredientEntity(
          mealId: mealId,
          weight: selectedFood.weight,
          foodId: foodId,
        );
        await createMealIngredientUseCase.execute(ingredient);
      }

      Get.back(result: true);
      Get.snackbar(
        'Success',
        'Meal created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save meal: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving = false;
      update();
    }
  }

  Future<void> saveMeal() async {
    if (isEditMode()) {
      await editMeal();
    } else {
      await createMeal();
    }
  }

  void onCancle() {
    Get.back(result: false);
  }

  void editFood(int index) {
    update();
  }
}
