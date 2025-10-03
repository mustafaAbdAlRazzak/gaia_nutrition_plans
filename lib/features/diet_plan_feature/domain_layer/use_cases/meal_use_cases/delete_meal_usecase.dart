import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_repository_interfaces.dart';

class DeleteMealUseCase {
  final MealRepositoryInterface repository;

  DeleteMealUseCase(this.repository);

  Future<void> execute(MealEntity meal) async {
    await repository.deleteMeal(meal);
  }
}
