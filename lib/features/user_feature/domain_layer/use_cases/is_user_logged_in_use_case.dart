import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class IsUserLoggedInUseCase {
  final UserRepositoryInterface repository;
  IsUserLoggedInUseCase(this.repository);
  bool execute() {
    return repository.isUserLoggedIn();
  }
}
