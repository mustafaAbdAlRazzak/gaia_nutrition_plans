import 'package:gaia_nutrition_plans/services_providers/sqflite_services_provider.dart';
import 'package:get/get.dart';

Future<void> sqfliteSetUp() async {
  await Get.putAsync<SqfliteServicesProvider>(
    () => SqfliteServicesProvider().init(),
  );
}
