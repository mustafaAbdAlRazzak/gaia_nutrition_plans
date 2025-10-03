import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class GetDietPlanFromAiUseCase {
  final DietPlanRepositoryInterface repository;
  GetDietPlanFromAiUseCase(this.repository);
  Future<Map<String, dynamic>> execute(String prompt) async {
    return await repository.getDietPlanFromAi(prompt);
  }
}
