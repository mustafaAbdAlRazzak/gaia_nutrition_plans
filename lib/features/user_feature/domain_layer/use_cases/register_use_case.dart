import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class RegisterUseCase {
  final UserRepositoryInterface repository;

  RegisterUseCase(this.repository);

  Future<void> execute({
    required UserEntity userEntity,
    required String password,
  }) async {
    await repository.register(userEntity: userEntity, password: password);
  }
}
