import 'package:gaia_nutrition_plans/services_providers/get_storage_services_provider.dart';
import 'package:get/get.dart';

Future<void> getStorageSetUp() async {
  await Get.putAsync<GetStorageServicesProvider>(
    () => GetStorageServicesProvider().init(),
  );
}
