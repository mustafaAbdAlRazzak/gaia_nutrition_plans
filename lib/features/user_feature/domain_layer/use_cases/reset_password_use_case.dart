import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class ResetPasswordUseCase {
  final UserRepositoryInterface repository;

  ResetPasswordUseCase(this.repository);

  Future<void> execute() async {
    await repository.resetPassword();
  }
}
