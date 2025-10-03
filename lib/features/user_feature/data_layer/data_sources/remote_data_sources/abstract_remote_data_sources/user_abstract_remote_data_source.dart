import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';

abstract class UserAbstractRemoteDataSources {
  Future<void> register({
    required UserEntity userEntity,
    required String password,
  });

  Future<void> login({required String email, required String password});

  Future<void> logout();

  Future<void> deleteAccount();

  Future<void> changePassword();

  Future<void> updateProfile(UserEntity userEntity);

  Future<UserEntity?> getCurrentUser();

  bool isUserLoggedIn();

  Future<UserEntity?> getUserById(String userId);

  String getCurrentUserId();

  Future<String?> getClientSecret();

  Future<bool?> isUserSubscribed();
}
