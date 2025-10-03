import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class GetDietPlansUseCase {
  final DietPlanRepositoryInterface repository;

  GetDietPlansUseCase(this.repository);

  Future<List<DietPlanEntity>> execute({
    required String searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    return await repository.getDietPlans(
      searchQuery: searchQuery,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
