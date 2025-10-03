import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class CreateDietPlanUseCase {
  final DietPlanRepositoryInterface repository;

  CreateDietPlanUseCase(this.repository);

  Future<int> execute(DietPlanEntity dietPlan) async {
    return await repository.createDietPlan(dietPlan);
  }
}
