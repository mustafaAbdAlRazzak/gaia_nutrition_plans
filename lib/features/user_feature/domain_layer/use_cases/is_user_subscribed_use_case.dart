import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class IsUserSubscribedUseCase {
  final UserRepositoryInterface repository;
  IsUserSubscribedUseCase(this.repository);
  Future<bool?> execute() async {
    return await repository.isUserSubscribed();
  }
}
