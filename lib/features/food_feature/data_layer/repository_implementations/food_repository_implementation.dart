import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/food_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/food_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/repositories_interfaces/food_repository_interface.dart';

class FoodRepositoryImplementation implements FoodRepositoryInterface {
  final FoodRemoteDataSources foodRemoteDataSources;
  final FoodLocalDataSources foodLocalDataSources;
  FoodRepositoryImplementation({
    required this.foodRemoteDataSources,
    required this.foodLocalDataSources,
  });

  @override
  Future<List<FoodEntity>> getFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    return await foodRemoteDataSources.getFoods(
      searchQuery: searchQuery,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  @override
  Future<List<FoodEntity>> getSavedFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    return await foodLocalDataSources.getSavedFoods(
      searchQuery: searchQuery,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  @override
  Future<int> saveFood(FoodEntity food) async {
    return await foodLocalDataSources.saveFood(food);
  }

  @override
  Future<void> unsaveFood(FoodEntity food) async {
    await foodLocalDataSources.unsaveFood(food);
  }

  @override
  Future<bool> isFoodSaved(FoodEntity food) async {
    return await foodLocalDataSources.isFoodSaved(food);
  }

  @override
  Future<FoodEntity> getFoodFormLocalDataBaseById(int id) async {
    return await foodLocalDataSources.getFoodFormLocalDataBaseById(id);
  }
}
