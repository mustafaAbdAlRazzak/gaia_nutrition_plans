import 'package:gaia_nutrition_plans/features/user_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/user_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class UserRepositoryImplementation implements UserRepositoryInterface {
  final UserAbstractRemoteDataSources remoteDataSource;

  UserRepositoryImplementation(this.remoteDataSource);

  @override
  Future<void> register({
    required UserEntity userEntity,
    required String password,
  }) async {
    await remoteDataSource.register(userEntity: userEntity, password: password);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    return await remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUserProfile() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> updateProfile(UserEntity userEntity) async {
    return await remoteDataSource.updateProfile(userEntity);
  }

  @override
  Future<void> deleteAccount() async {
    return await remoteDataSource.deleteAccount();
  }

  @override
  Future<void> resetPassword() async {
    return await remoteDataSource.changePassword();
  }

  @override
  bool isUserLoggedIn() {
    return remoteDataSource.isUserLoggedIn();
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    return remoteDataSource.getUserById(userId);
  }

  @override
  String getCurrentUserId() {
    return remoteDataSource.getCurrentUserId();
  }

  @override
  Future<String?> getClientSecret() async {
    return await remoteDataSource.getClientSecret();
  }

  @override
  Future<bool?> isUserSubscribed() async {
    return await remoteDataSource.isUserSubscribed();
  }
}
