import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class DeleteAccountUseCase {
  final UserRepositoryInterface repository;

  DeleteAccountUseCase(this.repository);

  Future<void> execute() async {
    return await repository.deleteAccount();
  }
}
