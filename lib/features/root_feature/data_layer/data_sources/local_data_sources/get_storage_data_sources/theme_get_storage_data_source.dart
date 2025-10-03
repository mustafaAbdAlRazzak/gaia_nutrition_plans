import 'package:gaia_nutrition_plans/features/root_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/theme_abstract_local_data_source.dart';
import 'package:get_storage/get_storage.dart';

class ThemeGetStorageDataSource implements ThemeAbstractLocalDataSource {
  final GetStorage getStorage;
  ThemeGetStorageDataSource({required this.getStorage});

  @override
  Future<bool> getThemeMode() async {
    if (await getStorage.read('isDarkMode') == null) {
      await getStorage.write('isDarkMode', false);
      return false;
    } else {
      return await getStorage.read('isDarkMode');
    }
  }

  @override
  Future<void> setThemeMode(bool isDarkMode) async {
    await getStorage.write('isDarkMode', isDarkMode);
  }
}
