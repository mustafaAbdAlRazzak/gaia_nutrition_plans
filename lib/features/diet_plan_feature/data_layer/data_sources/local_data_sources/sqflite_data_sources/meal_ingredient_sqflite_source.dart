import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_ingredient_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/mappers/local_mappers/sqflite_meal_ingredient_mapper.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:sqflite/sqflite.dart';

class MealIngredientSqfliteSource implements MealIngredientLocalDataSource {
  final Database database;
  final String mealIngredientsTableName = 'meal_ingredients';
  final String foodsTableName = 'foods';

  MealIngredientSqfliteSource(this.database);

  @override
  Future<int> createMealIngredient(MealIngredientEntity mealIngredient) async {
    final model = SqfliteMealIngredientMapper.toModel(mealIngredient);

    return await database.insert(
      mealIngredientsTableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateMealIngredient(MealIngredientEntity mealIngredient) async {
    final model = SqfliteMealIngredientMapper.toModel(mealIngredient);

    await database.update(
      mealIngredientsTableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [mealIngredient.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteMealIngredient(MealIngredientEntity mealIngredient) async {
    if (mealIngredient.id == null) return;

    await database.delete(
      mealIngredientsTableName,
      where: 'id = ?',
      whereArgs: [mealIngredient.id],
    );
  }

  @override
  Future<String> getMealIngredientName(
    MealIngredientEntity mealIngredient,
  ) async {
    final result = await database.query(
      foodsTableName,
      columns: ['name'],
      where: 'id = ?',
      whereArgs: [mealIngredient.foodId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['name'] as String;
    } else {
      throw Exception('Food not found for foodId: ${mealIngredient.foodId}');
    }
  }

  Future<double> _getNutritionValue(
    MealIngredientEntity mealIngredient,
    String nutrientColumn,
  ) async {
    final result = await database.rawQuery(
      '''
      SELECT f.$nutrientColumn, mi.weight
      FROM $mealIngredientsTableName mi
      INNER JOIN $foodsTableName f ON mi.foodId = f.id
      WHERE mi.id = ?
      LIMIT 1
    ''',
      [mealIngredient.id],
    );

    if (result.isEmpty) {
      throw Exception('Meal ingredient not found: ${mealIngredient.id}');
    }

    final row = result.first;
    final double nutrientPer100g = (row[nutrientColumn] as num).toDouble();
    final double weight = (row['weight'] as num).toDouble();

    return nutrientPer100g * (weight / 100.0);
  }

  @override
  Future<double> getMealIngredientCalories(
    MealIngredientEntity mealIngredient,
  ) {
    return _getNutritionValue(mealIngredient, 'calories');
  }

  @override
  Future<double> getMealIngredientProtein(MealIngredientEntity mealIngredient) {
    return _getNutritionValue(mealIngredient, 'protein');
  }

  @override
  Future<double> getMealIngredientFat(MealIngredientEntity mealIngredient) {
    return _getNutritionValue(mealIngredient, 'fat');
  }

  @override
  Future<double> getMealIngredientCarbohydrate(
    MealIngredientEntity mealIngredient,
  ) {
    return _getNutritionValue(mealIngredient, 'carbohydrate');
  }
}
