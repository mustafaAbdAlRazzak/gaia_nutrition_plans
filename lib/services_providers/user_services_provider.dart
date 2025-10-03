import 'package:gaia_nutrition_plans/features/user_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/user_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/user_feature/data_layer/data_sources/remote_data_sources/supabses_data_sources/user_supabase_data_source.dart';
import 'package:gaia_nutrition_plans/features/user_feature/data_layer/repository_implementations/user_repository_implementation.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_client_secret_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_current_user_id_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/is_user_subscribed_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/reset_password_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/delete_account_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_current_user_profile_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_user_by_id_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/is_user_logged_in_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/login_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/logout_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/register_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/update_profile_use_case.dart';
import 'package:gaia_nutrition_plans/services_providers/http_client_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/supabase_services_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserServicesProvider extends GetxService {
  late final Client _client;
  late final SupabaseClient _supabaseClient;
  late final UserAbstractRemoteDataSources _userAbstractRemoteDataSources;
  late final UserRepositoryImplementation _userRepositoryImplementation;
  late final ResetPasswordUseCase changePasswordUseCase;
  late final DeleteAccountUseCase deleteAccountUseCase;
  late final GetCurrentUserProfileUseCase getCurrentUserProfileUseCase;
  late final LoginUseCase loginUseCase;
  late final LogoutUseCase logoutUseCase;
  late final RegisterUseCase registerUseCase;
  late final UpdateProfileUseCase updateProfileUseCase;
  late final GetUserByIdUseCase getUserByIdUseCase;
  late final IsUserLoggedInUseCase isUserLoggedInUseCase;
  late final GetCurrentUserIdUseCase getCurrentUserIdUseCase;
  late final GetClientSecretUseCase getClientSecretUseCase;
  late final IsUserSubscribedUseCase isUserSubscribedUseCase;

  Future<UserServicesProvider> init() async {
    _client = Get.find<HttpClientServicesProvider>().client;
    _supabaseClient = Get.find<SupabaseServicesProvider>().supabaseClient;
    _userAbstractRemoteDataSources = UserSupabaseDataSource(
      httpClient: _client,
      supabaseClient: _supabaseClient,
    );
    _userRepositoryImplementation = UserRepositoryImplementation(
      _userAbstractRemoteDataSources,
    );
    changePasswordUseCase = ResetPasswordUseCase(_userRepositoryImplementation);
    deleteAccountUseCase = DeleteAccountUseCase(_userRepositoryImplementation);
    getCurrentUserProfileUseCase = GetCurrentUserProfileUseCase(
      _userRepositoryImplementation,
    );
    loginUseCase = LoginUseCase(_userRepositoryImplementation);
    logoutUseCase = LogoutUseCase(_userRepositoryImplementation);
    registerUseCase = RegisterUseCase(_userRepositoryImplementation);
    updateProfileUseCase = UpdateProfileUseCase(_userRepositoryImplementation);
    getUserByIdUseCase = GetUserByIdUseCase(_userRepositoryImplementation);
    isUserLoggedInUseCase = IsUserLoggedInUseCase(
      _userRepositoryImplementation,
    );
    getCurrentUserIdUseCase = GetCurrentUserIdUseCase(
      _userRepositoryImplementation,
    );
    getClientSecretUseCase = GetClientSecretUseCase(
      _userRepositoryImplementation,
    );
    isUserSubscribedUseCase = IsUserSubscribedUseCase(
      _userRepositoryImplementation,
    );
    return this;
  }
}
