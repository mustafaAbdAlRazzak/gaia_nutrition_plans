import 'package:gaia_nutrition_plans/features/food_feature/data_layer/mappers/remote_mappers/f_d_c_mappers/f_d_c_food_mapper.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/models/remote_models/f_d_c_models/f_d_c_food_model.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/food_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FDCFoodDataSource implements FoodRemoteDataSources {
  final SupabaseClient supabaseClient;
  FDCFoodDataSource(this.supabaseClient);

  @override
  Future<List<FoodEntity>> getFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await supabaseClient.functions.invoke(
        'get-foods',
        body: {
          'searchQuery': searchQuery,
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      final data = response.data as Map<String, dynamic>;
      final foods = data['foods'] as List<dynamic>? ?? [];
      return foods
          .map((item) => FDCFoodMapper.toEntity(FDCFoodModel.fromJson(item)))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
