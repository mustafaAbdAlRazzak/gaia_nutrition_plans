import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/diet_plan_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/mappers/local_mappers/sqflite_diet_plan_mapper.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/mappers/local_mappers/sqflite_meal_mapper.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_diet_plan_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_meal_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:sqflite/sqflite.dart';

class DietPlanSqfliteSource implements DietPlanLocalDataSource {
  final Database database;
  final String dietPlansTableName = 'diet_plans';
  final String mealsTableName = 'meals';
  final String mealIngredientsTableName = 'meal_ingredients';
  final String foodsTableName = 'foods';

  DietPlanSqfliteSource(this.database);

  @override
  Future<int> createDietPlan(DietPlanEntity dietPlan) async {
    final model = SqfliteDietPlanMapper.toModel(dietPlan);
    return await database.insert(
      dietPlansTableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteDietPlan(DietPlanEntity dietPlan) async {
    final id = dietPlan.id;
    if (id != null) {
      await database.delete(
        dietPlansTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  @override
  Future<List<DietPlanEntity>> getDietPlans({
    required String searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    final offset = (pageNumber - 1) * pageSize;
    final maps = await database.query(
      dietPlansTableName,
      where: 'name LIKE ?',
      whereArgs: ['%$searchQuery%'],
      limit: pageSize,
      offset: offset,
      orderBy: 'id ASC',
    );
    return maps
        .map(
          (map) =>
              SqfliteDietPlanMapper.toEntity(SqfliteDietPlanModel.fromMap(map)),
        )
        .toList();
  }

  @override
  Future<void> updateDietPlan(DietPlanEntity dietPlan) async {
    final model = SqfliteDietPlanMapper.toModel(dietPlan);
    await database.update(
      dietPlansTableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [dietPlan.id],
    );
  }

  @override
  Future<List<MealEntity>> getDietPlanMeal(DietPlanEntity dietPlan) async {
    if (dietPlan.id == null) return [];

    final maps = await database.query(
      mealsTableName,
      where: 'dietPlanId = ?',
      whereArgs: [dietPlan.id],
      orderBy: 'id ASC',
    );

    return maps.map((map) {
      return SqfliteMealMapper.toEntity(SqfliteMealModel.fromMap(map));
    }).toList();
  }

  @override
  Future<double> getTotalCalories(DietPlanEntity dietPlan) async {
    return await _getNutrientSum(dietPlan.id, 'calories');
  }

  @override
  Future<double> getTotalCarbohydrate(DietPlanEntity dietPlan) async {
    return await _getNutrientSum(dietPlan.id, 'carbohydrate');
  }

  @override
  Future<double> getTotalFat(DietPlanEntity dietPlan) async {
    return await _getNutrientSum(dietPlan.id, 'fat');
  }

  @override
  Future<double> getTotalProtein(DietPlanEntity dietPlan) async {
    return await _getNutrientSum(dietPlan.id, 'protein');
  }

  Future<double> _getNutrientSum(int? dietPlanId, String nutrientColumn) async {
    if (dietPlanId == null) return 0.0;

    final result = await database.rawQuery(
      '''
      SELECT SUM(mi.weight * f.$nutrientColumn / 100.0) as total
      FROM $mealIngredientsTableName mi
      INNER JOIN $foodsTableName f ON mi.foodId = f.id
      INNER JOIN $mealsTableName m ON mi.mealId = m.id
      WHERE m.dietPlanId = ?
    ''',
      [dietPlanId],
    );

    final total = result.first['total'] as num?;
    return total?.toDouble() ?? 0.0;
  }
}
