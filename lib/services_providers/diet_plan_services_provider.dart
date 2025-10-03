import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/diet_plan_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_ingredient_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/sqflite_data_sources/diet_plan_sqflite_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/sqflite_data_sources/meal_ingredient_sqflite_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/sqflite_data_sources/meal_sqflite_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/diet_plan_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/remote_data_sources/cohere_data_sources/diet_plan_cohere_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/repository_implementations/diet_plan_repository_implementation.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/repository_implementations/meal_ingredient_repository_implementation.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/repository_implementations/meal_repository_implementation.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/create_diet_plan_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/delete_diet_plan_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_diet_plan_from_ai_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_diet_plan_meal_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_diet_plans_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_calories_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_carbohydrate_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_fat_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_total_protein_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/update_diet_plan_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/create_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/delete_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/get_meal_ingredient_calories_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/get_meal_ingredient_carbohydrate_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/get_meal_ingredient_fat_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/get_meal_ingredient_name_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/get_meal_ingredient_protein_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_ingredient_use_cases/update_meal_ingredient_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/create_meal_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/delete_meal_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_calories_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_carbohydrate_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_fat_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_ingredients_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/get_meal_protein_usecase.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/meal_use_cases/update_meal_usecase.dart';
import 'package:gaia_nutrition_plans/services_providers/sqflite_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/supabase_services_provider.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DietPlanServicesProvider extends GetxService {
  late final Database _database;
  late final SupabaseClient _supabaseClient;
  late final DietPlanLocalDataSource _dietPlanLocalDataSource;
  late final DietPlanAbstractRemoteDataSource _dietPlanRemoteDataSource;
  late final DietPlanRepositoryImplementation _dietPlanRepositoryImplementation;
  late final CreateDietPlanUseCase createDietPlanUseCase;
  late final DeleteDietPlanUseCase deleteDietPlanUseCase;
  late final GetDietPlansUseCase getDietPlansUseCase;
  late final UpdateDietPlanUseCase updateDietPlanUseCase;
  late final GetDietPlanMealUseCase getDietPlanMealUseCase;
  late final GetTotalCaloriesUseCase getTotalCaloriesUseCase;
  late final GetTotalProteinUseCase getTotalProteinUseCase;
  late final GetTotalFatUseCase getTotalFatUseCase;
  late final GetTotalCarbohydrateUseCase getTotalCarbohydrateUseCase;
  late final MealLocalDataSource _mealLocalDataSource;
  late final MealRepositoryImplementation _mealRepositoryImplementation;
  late final CreateMealUseCase createMealUseCase;
  late final DeleteMealUseCase deleteMealUseCase;
  late final UpdateMealUseCase updateMealUseCase;
  late final GetMealIngredientsUseCase getMealIngredientsUseCase;
  late final GetMealCaloriesUseCase getMealCaloriesUseCase;
  late final GetMealProteinUseCase getMealProteinUseCase;
  late final GetMealFatUseCase getMealFatUseCase;
  late final GetMealCarbohydrateUseCase getMealCarbohydrateUseCase;
  late final MealIngredientLocalDataSource _mealIngredientLocalDataSource;
  late final MealIngredientRepositoryImplementation
  _mealIngredientRepositoryImplementation;
  late final CreateMealIngredientUseCase createMealIngredientUseCase;
  late final DeleteMealIngredientUseCase deleteMealIngredientUseCase;
  late final UpdateMealIngredientUseCase updateMealIngredientUseCase;
  late final GetMealIngredientNameUseCase getMealIngredientNameUseCase;
  late final GetMealIngredientCaloriesUseCase getMealIngredientCaloriesUseCase;
  late final GetMealIngredientProteinUseCase getMealIngredientProteinUseCase;
  late final GetMealIngredientFatUseCase getMealIngredientFatUseCase;
  late final GetMealIngredientCarbohydrateUseCase
  getMealIngredientCarbohydrateUseCase;
  late final GetDietPlanFromAiUseCase getDietPlanFromAiUseCase;

  Future<DietPlanServicesProvider> init() async {
    _database = Get.find<SqfliteServicesProvider>().database;
    _supabaseClient = Get.find<SupabaseServicesProvider>().supabaseClient;
    _dietPlanLocalDataSource = DietPlanSqfliteSource(_database);
    _dietPlanRemoteDataSource = DietPlanCohereDataSource(_supabaseClient);
    _dietPlanRepositoryImplementation = DietPlanRepositoryImplementation(
      dietPlanLocalDataSource: _dietPlanLocalDataSource,
      dietPlanAbstractRemoteDataSource: _dietPlanRemoteDataSource,
    );
    createDietPlanUseCase = CreateDietPlanUseCase(
      _dietPlanRepositoryImplementation,
    );
    deleteDietPlanUseCase = DeleteDietPlanUseCase(
      _dietPlanRepositoryImplementation,
    );
    getDietPlansUseCase = GetDietPlansUseCase(
      _dietPlanRepositoryImplementation,
    );
    updateDietPlanUseCase = UpdateDietPlanUseCase(
      _dietPlanRepositoryImplementation,
    );
    getDietPlanMealUseCase = GetDietPlanMealUseCase(
      _dietPlanRepositoryImplementation,
    );
    getTotalCaloriesUseCase = GetTotalCaloriesUseCase(
      _dietPlanRepositoryImplementation,
    );
    getTotalProteinUseCase = GetTotalProteinUseCase(
      _dietPlanRepositoryImplementation,
    );
    getTotalFatUseCase = GetTotalFatUseCase(_dietPlanRepositoryImplementation);
    getTotalCarbohydrateUseCase = GetTotalCarbohydrateUseCase(
      _dietPlanRepositoryImplementation,
    );
    _mealLocalDataSource = MealSqfliteSource(_database);
    _mealRepositoryImplementation = MealRepositoryImplementation(
      _mealLocalDataSource,
    );
    createMealUseCase = CreateMealUseCase(_mealRepositoryImplementation);
    deleteMealUseCase = DeleteMealUseCase(_mealRepositoryImplementation);
    updateMealUseCase = UpdateMealUseCase(_mealRepositoryImplementation);
    getMealIngredientsUseCase = GetMealIngredientsUseCase(
      _mealRepositoryImplementation,
    );
    getMealCaloriesUseCase = GetMealCaloriesUseCase(
      _mealRepositoryImplementation,
    );
    getMealProteinUseCase = GetMealProteinUseCase(
      _mealRepositoryImplementation,
    );
    getMealFatUseCase = GetMealFatUseCase(_mealRepositoryImplementation);
    getMealCarbohydrateUseCase = GetMealCarbohydrateUseCase(
      _mealRepositoryImplementation,
    );
    _mealIngredientLocalDataSource = MealIngredientSqfliteSource(_database);
    _mealIngredientRepositoryImplementation =
        MealIngredientRepositoryImplementation(_mealIngredientLocalDataSource);
    createMealIngredientUseCase = CreateMealIngredientUseCase(
      _mealIngredientRepositoryImplementation,
    );
    deleteMealIngredientUseCase = DeleteMealIngredientUseCase(
      _mealIngredientRepositoryImplementation,
    );
    updateMealIngredientUseCase = UpdateMealIngredientUseCase(
      _mealIngredientRepositoryImplementation,
    );
    getMealIngredientNameUseCase = GetMealIngredientNameUseCase(
      _mealIngredientRepositoryImplementation,
    );
    getMealIngredientCaloriesUseCase = GetMealIngredientCaloriesUseCase(
      _mealIngredientRepositoryImplementation,
    );
    getMealIngredientProteinUseCase = GetMealIngredientProteinUseCase(
      _mealIngredientRepositoryImplementation,
    );
    getDietPlanFromAiUseCase = GetDietPlanFromAiUseCase(
      _dietPlanRepositoryImplementation,
    );
    return this;
  }
}
