import 'package:gaia_nutrition_plans/set_up_files/diet_plan_services_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/food_services_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/get_storage_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/http_client_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/root_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/sqflite_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/supabase_set_up.dart';
import 'package:gaia_nutrition_plans/set_up_files/user_services_set_up.dart';

Future<void> appSetUp() async {
  await getStorageSetUp();
  await supabaseSetUp();
  await httpClientSetUp();
  await userServicesSetUp();
  await sqfliteSetUp();
  await foodServicesSetUp();
  await dietPlanServicesSetUp();
  await rootSetUp();
}
