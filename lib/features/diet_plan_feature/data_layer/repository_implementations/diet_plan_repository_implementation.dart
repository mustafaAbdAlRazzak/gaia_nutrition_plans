import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/diet_plan_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/diet_plan_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class DietPlanRepositoryImplementation implements DietPlanRepositoryInterface {
  final DietPlanLocalDataSource dietPlanLocalDataSource;
  final DietPlanAbstractRemoteDataSource dietPlanAbstractRemoteDataSource;
  DietPlanRepositoryImplementation({
    required this.dietPlanLocalDataSource,
    required this.dietPlanAbstractRemoteDataSource,
  });

  @override
  Future<int> createDietPlan(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.createDietPlan(dietPlan);
  }

  @override
  Future<void> deleteDietPlan(DietPlanEntity dietPlan) async {
    await dietPlanLocalDataSource.deleteDietPlan(dietPlan);
  }

  @override
  Future<List<DietPlanEntity>> getDietPlans({
    required String searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    return await dietPlanLocalDataSource.getDietPlans(
      searchQuery: searchQuery,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  @override
  Future<void> updateDietPlan(DietPlanEntity dietPlan) async {
    await dietPlanLocalDataSource.updateDietPlan(dietPlan);
  }

  @override
  Future<List<MealEntity>> getDietPlanMeal(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.getDietPlanMeal(dietPlan);
  }

  @override
  Future<double> getTotalCalories(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.getTotalCalories(dietPlan);
  }

  @override
  Future<double> getTotalCarbohydrate(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.getTotalCarbohydrate(dietPlan);
  }

  @override
  Future<double> getTotalFat(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.getTotalFat(dietPlan);
  }

  @override
  Future<double> getTotalProtein(DietPlanEntity dietPlan) async {
    return await dietPlanLocalDataSource.getTotalProtein(dietPlan);
  }

  @override
  Future<Map<String, dynamic>> getDietPlanFromAi(String prompt) async {
    return await dietPlanAbstractRemoteDataSource.getDietPlanFromAi(prompt);
  }
}
