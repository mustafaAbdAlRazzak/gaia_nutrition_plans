import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/food_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class AiDietPlanGeneratorController extends GetxController {
  // Services
  late final DietPlanServicesProvider _dietPlanServices;
  late final UserServicesProvider _userServices;
  late final FoodServicesProvider _foodServices;

  // Form data
  String selectedGoal = 'weight_loss';
  int selectedWorkoutDays = 3;
  int selectedMealsCount = 4;
  String selectedDietaryRestrictions = 'none';
  String selectedPlanDuration = 'week';

  // Loading state
  bool isGenerating = false;

  // Options
  final List<Map<String, String>> goals = [
    {'value': 'weight_loss', 'label': 'Weight Loss'},
    {'value': 'muscle_gain', 'label': 'Muscle Gain'},
    {'value': 'maintain_weight', 'label': 'Maintain Weight'},
  ];

  final List<Map<String, dynamic>> workoutDaysOptions = [
    {'value': 0, 'label': '0 Days'},
    {'value': 1, 'label': '1 Day'},
    {'value': 2, 'label': '2 Days'},
    {'value': 3, 'label': '3 Days'},
    {'value': 4, 'label': '4 Days'},
    {'value': 5, 'label': '5 Days'},
    {'value': 6, 'label': '6 Days'},
    {'value': 7, 'label': '7 Days'},
  ];

  final List<Map<String, dynamic>> mealsCountOptions = [
    {'value': 3, 'label': '3 Meals'},
    {'value': 4, 'label': '4 Meals'},
    {'value': 5, 'label': '5 Meals'},
    {'value': 6, 'label': '6 Meals'},
  ];

  final List<Map<String, String>> dietaryRestrictions = [
    {'value': 'none', 'label': 'No Restrictions'},
    {'value': 'vegetarian', 'label': 'Vegetarian'},
    {'value': 'vegan', 'label': 'Vegan'},
    {'value': 'gluten_free', 'label': 'Gluten Free'},
    {'value': 'dairy_free', 'label': 'Dairy Free'},
    {'value': 'keto', 'label': 'Keto'},
    {'value': 'paleo', 'label': 'Paleo'},
  ];

  @override
  void onInit() {
    super.onInit();
    _dietPlanServices = Get.find<DietPlanServicesProvider>();
    _userServices = Get.find<UserServicesProvider>();
    _foodServices = Get.find<FoodServicesProvider>();
  }

  void updateGoal(String value) {
    selectedGoal = value;
    update();
  }

  void updateWorkoutDays(int value) {
    selectedWorkoutDays = value;
    update();
  }

  void updateMealsCount(int value) {
    selectedMealsCount = value;
    update();
  }

  void updateDietaryRestrictions(String value) {
    selectedDietaryRestrictions = value;
    update();
  }

  void updatePlanDuration(String value) {
    selectedPlanDuration = value;
    update();
  }

  Future<void> generateDietPlan() async {
    try {
      isGenerating = true;
      update();

      // Get current user data
      final UserEntity? currentUser = await _userServices
          .getCurrentUserProfileUseCase
          .execute();

      if (currentUser == null) {
        Get.snackbar('Error', 'Unable to get user profile');
        return;
      }

      // Build AI prompt
      final String prompt = _buildAiPrompt(currentUser);

      // Get diet plan from AI
      final Map<String, dynamic> aiResponse = await _dietPlanServices
          .getDietPlanFromAiUseCase
          .execute(prompt);

      // Save diet plan to database
      await _saveDietPlanToDatabase(aiResponse);

      // Return to previous page with success result
      Get.back(result: true);
      Get.snackbar('Success', 'Diet plan created successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate diet plan: ${e.toString()}');
    } finally {
      isGenerating = false;
      update();
    }
  }

  String _buildAiPrompt(UserEntity user) {
    final age = DateTime.now().year - user.birthday.year;
    final gender = user.gender ? 'Male' : 'Female';

    String goalText = '';
    switch (selectedGoal) {
      case 'weight_loss':
        goalText = 'lose weight';
        break;
      case 'muscle_gain':
        goalText = 'gain muscle mass';
        break;
      case 'maintain_weight':
        goalText = 'maintain current weight';
        break;
    }

    final String restrictionsText = selectedDietaryRestrictions == 'none'
        ? 'no dietary restrictions'
        : selectedDietaryRestrictions.replaceAll('_', ' ');

    return '''
Create a diet plan for:
- Gender: $gender
- Age: $age years
- Weight: ${user.weight} kg
- Height: ${user.height} cm
- Goal: $goalText
- Workout days per week: $selectedWorkoutDays
- Preferred meals per day: $selectedMealsCount
- Dietary restrictions: $restrictionsText

Please provide a balanced and nutritious meal plan with proper macronutrient distribution.
''';
  }

  Future<void> _saveDietPlanToDatabase(Map<String, dynamic> aiResponse) async {
    // Extract data from AI response
    final DietPlanEntity dietPlan = aiResponse['dietPlan'];
    final List<dynamic> meals = aiResponse['meals'];

    // Save diet plan first
    final int dietPlanId = await _dietPlanServices.createDietPlanUseCase
        .execute(dietPlan);

    // Save meals and ingredients
    for (final mealData in meals) {
      final MealEntity meal = mealData['meal'];
      final List<dynamic> ingredients = mealData['ingredients'];

      // Create meal with diet plan ID
      final MealEntity mealWithDietPlanId = MealEntity(
        id: meal.id,
        dietPlanId: dietPlanId,
        name: meal.name,
        description: meal.description,
      );

      // Save meal
      final int mealId = await _dietPlanServices.createMealUseCase.execute(
        mealWithDietPlanId,
      );

      // Save ingredients
      for (final ingredientData in ingredients) {
        final MealIngredientEntity mealIngredient =
            ingredientData['mealIngredient'];
        final FoodEntity food = ingredientData['food'];

        // Save food first (assuming SaveFoodUseCase exists in services)
        final int foodId = await _foodServices.saveFoodUseCase.execute(food);

        // Create meal ingredient with proper IDs
        final MealIngredientEntity mealIngredientWithIds = MealIngredientEntity(
          id: mealIngredient.id,
          mealId: mealId,
          weight: mealIngredient.weight,
          foodId: foodId,
        );

        // Save meal ingredient
        await _dietPlanServices.createMealIngredientUseCase.execute(
          mealIngredientWithIds,
        );
      }
    }
  }
}
