import 'package:gaia_nutrition_plans/features/root_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/theme_abstract_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/root_feature/data_layer/data_sources/local_data_sources/get_storage_data_sources/theme_get_storage_data_source.dart';
import 'package:gaia_nutrition_plans/features/root_feature/data_layer/repository_implementations/theme_repository_implemntation.dart';
import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/use_cases/theme_use_cases/get_theme_mode_use_case.dart';
import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/use_cases/theme_use_cases/set_theme_mode_use_case.dart';
import 'package:gaia_nutrition_plans/services_providers/get_storage_services_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RootServicesProvider extends GetxService {
  late final GetStorage _getStorage;
  late final ThemeAbstractLocalDataSource _themeAbstractLocalDataSource;
  late final ThemeRepositoryImplemntation _themeRepositoryImplemntation;
  late final GetThemeModeUseCase getThemeModeUseCase;
  late final SetThemeModeUseCase setThemeModeUseCase;
  Future<RootServicesProvider> init() async {
    _getStorage = Get.find<GetStorageServicesProvider>().getStorage;
    _themeAbstractLocalDataSource = ThemeGetStorageDataSource(
      getStorage: _getStorage,
    );
    _themeRepositoryImplemntation = ThemeRepositoryImplemntation(
      themeAbstractLocalDataSource: _themeAbstractLocalDataSource,
    );
    getThemeModeUseCase = GetThemeModeUseCase(
      themeRepositoryInterface: _themeRepositoryImplemntation,
    );
    setThemeModeUseCase = SetThemeModeUseCase(
      themeRepositoryInterface: _themeRepositoryImplemntation,
    );
    return this;
  }
}
