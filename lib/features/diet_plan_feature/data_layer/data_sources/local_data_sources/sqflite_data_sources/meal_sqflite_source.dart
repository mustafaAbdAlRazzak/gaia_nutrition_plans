import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/mappers/local_mappers/sqflite_meal_ingredient_mapper.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/mappers/local_mappers/sqflite_meal_mapper.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_meal_ingredient_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:sqflite/sqflite.dart';

class MealSqfliteSource implements MealLocalDataSource {
  final Database database;
  final String mealsTableName = 'meals';
  final String mealIngredientsTableName = 'meal_ingredients';
  final String foodsTableName = 'foods';

  MealSqfliteSource(this.database);

  @override
  Future<int> createMeal(MealEntity meal) async {
    final model = SqfliteMealMapper.toModel(meal);
    return await database.insert(
      mealsTableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateMeal(MealEntity meal) async {
    if (meal.id == null) {
      throw ArgumentError('Meal ID is required for update');
    }

    final model = SqfliteMealMapper.toModel(meal);
    await database.update(
      mealsTableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  @override
  Future<void> deleteMeal(MealEntity meal) async {
    if (meal.id == null) {
      throw ArgumentError('Meal ID is required for delete');
    }

    await database.delete(
      mealsTableName,
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  @override
  Future<List<MealIngredientEntity>> getMealIngredients(MealEntity meal) async {
    if (meal.id == null) return [];

    final maps = await database.query(
      mealIngredientsTableName,
      where: 'mealId = ?',
      whereArgs: [meal.id],
      orderBy: 'id ASC',
    );

    return maps.map((map) {
      return SqfliteMealIngredientMapper.toEntity(
        SqfliteMealIngredientModel.fromMap(map),
      );
    }).toList();
  }

  @override
  Future<double> getMealCalories(MealEntity meal) async {
    return await _getNutrientSum(meal.id, 'calories');
  }

  @override
  Future<double> getMealCarbohydrate(MealEntity meal) async {
    return await _getNutrientSum(meal.id, 'carbohydrate');
  }

  @override
  Future<double> getMealFat(MealEntity meal) async {
    return await _getNutrientSum(meal.id, 'fat');
  }

  @override
  Future<double> getMealProtein(MealEntity meal) async {
    return await _getNutrientSum(meal.id, 'protein');
  }

  Future<double> _getNutrientSum(int? mealId, String nutrientColumn) async {
    if (mealId == null) return 0.0;

    final result = await database.rawQuery(
      '''
      SELECT SUM(mi.weight * f.$nutrientColumn / 100.0) AS total
      FROM $mealIngredientsTableName mi
      INNER JOIN $foodsTableName f ON mi.foodId = f.id
      WHERE mi.mealId = ?
    ''',
      [mealId],
    );

    final total = result.first['total'] as num?;
    return total?.toDouble() ?? 0.0;
  }
}
