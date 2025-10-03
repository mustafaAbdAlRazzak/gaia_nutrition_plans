import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class UpdateProfileUseCase {
  final UserRepositoryInterface repository;

  UpdateProfileUseCase(this.repository);

  Future<void> execute(UserEntity userEntity) async {
    await repository.updateProfile(userEntity);
  }
}
