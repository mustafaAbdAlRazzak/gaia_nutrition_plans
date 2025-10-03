import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageServicesProvider extends GetxService {
  late final GetStorage getStorage;

  Future<GetStorageServicesProvider> init() async {
    await GetStorage.init();
    getStorage = GetStorage();
    return this;
  }
}
