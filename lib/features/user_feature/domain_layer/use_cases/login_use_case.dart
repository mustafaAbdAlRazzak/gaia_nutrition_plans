import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class LoginUseCase {
  final UserRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    await repository.login(email: email, password: password);
  }
}
