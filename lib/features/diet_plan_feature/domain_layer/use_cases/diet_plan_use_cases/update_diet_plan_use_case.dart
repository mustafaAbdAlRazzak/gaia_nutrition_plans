import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class UpdateDietPlanUseCase {
  final DietPlanRepositoryInterface repository;

  UpdateDietPlanUseCase(this.repository);

  Future<void> execute(DietPlanEntity dietPlan) async {
    await repository.updateDietPlan(dietPlan);
  }
}
