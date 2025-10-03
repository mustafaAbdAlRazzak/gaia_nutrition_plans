import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class GetCurrentUserProfileUseCase {
  final UserRepositoryInterface repository;

  GetCurrentUserProfileUseCase(this.repository);

  Future<UserEntity?> execute() async {
    return await repository.getCurrentUserProfile();
  }
}
