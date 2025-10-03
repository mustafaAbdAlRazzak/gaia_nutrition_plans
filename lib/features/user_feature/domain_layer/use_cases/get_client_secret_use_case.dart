import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class GetClientSecretUseCase {
  final UserRepositoryInterface userRepositoryInterface;
  GetClientSecretUseCase(this.userRepositoryInterface);
  Future<String?> execute() async =>
      await userRepositoryInterface.getClientSecret();
}
