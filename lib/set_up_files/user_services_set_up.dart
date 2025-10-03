import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

Future<void> userServicesSetUp() async {
  await Get.putAsync<UserServicesProvider>(() => UserServicesProvider().init());
}
