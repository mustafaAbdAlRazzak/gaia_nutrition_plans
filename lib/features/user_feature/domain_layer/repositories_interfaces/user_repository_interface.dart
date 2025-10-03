import '../entities/user_entity.dart';

abstract class UserRepositoryInterface {
  Future<void> register({
    required UserEntity userEntity,
    required String password,
  });

  Future<void> login({required String email, required String password});

  Future<void> logout();

  Future<void> deleteAccount();

  Future<void> resetPassword();

  Future<void> updateProfile(UserEntity userEntity);

  Future<UserEntity?> getCurrentUserProfile();

  Future<UserEntity?> getUserById(String userId);

  bool isUserLoggedIn();

  String getCurrentUserId();

  Future<String?> getClientSecret();

  Future<bool?> isUserSubscribed();
}
