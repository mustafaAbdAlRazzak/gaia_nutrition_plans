import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class LogoutUseCase {
  final UserRepositoryInterface repository;

  LogoutUseCase(this.repository);

  Future<void> execute() async {
    return await repository.logout();
  }
}
