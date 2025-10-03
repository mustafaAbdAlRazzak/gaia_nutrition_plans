import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/food_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/local_data_sources/sqflite_data_sources/food_sqflite_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/food_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/remote_data_sources/f_d_c_data_sources/f_d_c_food_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/repository_implementations/food_repository_implementation.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_food_form_local_data_base_by_id_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_foods_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_saved_foods_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/is_food_saved_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/save_food_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/unsave_food_use_case.dart';
import 'package:gaia_nutrition_plans/services_providers/sqflite_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/supabase_services_provider.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodServicesProvider extends GetxService {
  late final SupabaseClient _supabaseClient;
  late final Database _database;
  late final FoodRemoteDataSources _foodRemoteDataSources;
  late final FoodLocalDataSources _foodLocalDataSources;
  late final FoodRepositoryImplementation _foodRepositoryImplementation;
  late final GetFoodsUseCase getFoodsUseCase;
  late final GetSavedFoodsUseCase getSavedFoodsUseCase;
  late final SaveFoodUseCase saveFoodUseCase;
  late final UnsaveFoodUseCase unsaveFoodUseCase;
  late final IsFoodSavedUseCase isFoodSavedUseCase;
  late final GetFoodFormLocalDataBaseByIdUseCase
  getFoodFormLocalDataBaseByIdUseCase;

  Future<FoodServicesProvider> init() async {
    _supabaseClient = Get.find<SupabaseServicesProvider>().supabaseClient;
    _database = Get.find<SqfliteServicesProvider>().database;
    _foodRemoteDataSources = FDCFoodDataSource(_supabaseClient);
    _foodLocalDataSources = FoodSqfliteDataSource(_database);
    _foodRepositoryImplementation = FoodRepositoryImplementation(
      foodLocalDataSources: _foodLocalDataSources,
      foodRemoteDataSources: _foodRemoteDataSources,
    );
    getSavedFoodsUseCase = GetSavedFoodsUseCase(_foodRepositoryImplementation);
    getFoodsUseCase = GetFoodsUseCase(_foodRepositoryImplementation);
    saveFoodUseCase = SaveFoodUseCase(_foodRepositoryImplementation);
    unsaveFoodUseCase = UnsaveFoodUseCase(_foodRepositoryImplementation);
    isFoodSavedUseCase = IsFoodSavedUseCase(_foodRepositoryImplementation);
    getFoodFormLocalDataBaseByIdUseCase = GetFoodFormLocalDataBaseByIdUseCase(
      _foodRepositoryImplementation,
    );
    return this;
  }
}
