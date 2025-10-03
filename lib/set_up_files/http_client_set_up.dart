import 'package:gaia_nutrition_plans/services_providers/http_client_services_provider.dart';
import 'package:get/get.dart';

Future<void> httpClientSetUp() async {
  await Get.putAsync<HttpClientServicesProvider>(
    () => HttpClientServicesProvider().init(),
  );
}
