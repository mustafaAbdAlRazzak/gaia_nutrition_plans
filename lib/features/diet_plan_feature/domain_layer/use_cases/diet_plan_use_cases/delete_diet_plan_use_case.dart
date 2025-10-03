import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class DeleteDietPlanUseCase {
  final DietPlanRepositoryInterface repository;

  DeleteDietPlanUseCase(this.repository);

  Future<void> execute(DietPlanEntity dietPlan) async {
    return await repository.deleteDietPlan(dietPlan);
  }
}
