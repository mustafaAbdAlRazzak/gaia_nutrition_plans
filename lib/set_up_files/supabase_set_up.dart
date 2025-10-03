import 'package:gaia_nutrition_plans/services_providers/supabase_services_provider.dart';
import 'package:get/get.dart';

Future<void> supabaseSetUp() async {
  await Get.putAsync<SupabaseServicesProvider>(
    () => SupabaseServicesProvider().init(),
  );
}
