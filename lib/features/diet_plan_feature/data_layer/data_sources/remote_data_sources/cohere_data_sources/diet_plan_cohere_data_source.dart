import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/diet_plan_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/remote_models/cohere_models/diet_plan_cohere_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/remote_models/cohere_models/meal_cohere_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/remote_models/cohere_models/meal_ingredient_cohere_model.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/models/remote_models/cohere_models/food_cohere_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DietPlanCohereDataSource implements DietPlanAbstractRemoteDataSource {
  final SupabaseClient _supabaseClient;
  DietPlanCohereDataSource(this._supabaseClient);

  @override
  Future<Map<String, dynamic>> getDietPlanFromAi(String prompt) async {
    final String? userId = _supabaseClient.auth.currentUser?.id;
    print('userId: $userId');
    final response = await _supabaseClient.functions.invoke(
      'generate-diet-plan',
      body: {'prompt': prompt, 'userId': userId},
    );
    if (response.status == 403) {
      throw Exception('User subscription is not active');
    }
    if (response.status != 200) {
      final data = response.data as Map<String, dynamic>?;
      throw Exception(data?['error'] ?? 'Failed to generate diet plan');
    }
    final data = response.data as Map<String, dynamic>;
    return convertResponseToEntityMap(data);
  }

  Map<String, dynamic> convertResponseToEntityMap(Map<String, dynamic> json) {
    // 1) diet plan
    final dietPlanModel = DietPlanCohereModel.fromMap(json);
    final dietPlanEntity = dietPlanModel.toEntity();
    // 2) meals
    final mealsJson = json['meals'] as List<dynamic>;
    final meals = mealsJson.map((mealJson) {
      // meal entity
      final mealModel = MealCohereModel.fromMap(mealJson);
      final mealEntity = mealModel.toEntity();
      // ingredients
      final ingredientsJson = mealJson['ingredients'] as List<dynamic>;
      final ingredients = ingredientsJson.map((ingredientJson) {
        final mealIngredientModel = MealIngredientCohereModel.fromMap(
          ingredientJson,
        );
        final mealIngredientEntity = mealIngredientModel.toEntity();

        final foodModel = FoodCohereModel.fromMap(ingredientJson['food']);
        final foodEntity = foodModel.toEntity();

        return {'mealIngredient': mealIngredientEntity, 'food': foodEntity};
      }).toList();

      return {'meal': mealEntity, 'ingredients': ingredients};
    }).toList();
    return {'dietPlan': dietPlanEntity, 'meals': meals};
  }
}
