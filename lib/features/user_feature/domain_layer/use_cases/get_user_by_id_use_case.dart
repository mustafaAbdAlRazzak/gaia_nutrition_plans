import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class GetUserByIdUseCase {
  final UserRepositoryInterface repository;
  GetUserByIdUseCase(this.repository);

  Future<UserEntity?> execute(String userId) async {
    return await repository.getUserById(userId);
  }
}
