import 'package:gaia_nutrition_plans/features/food_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/food_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/mappers/local_mappers/sqflite_mappers/food_sqflite_mapper.dart';
import 'package:gaia_nutrition_plans/features/food_feature/data_layer/models/local_models/sqflite_models/food_sqflite_model.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:sqflite/sqflite.dart';

class FoodSqfliteDataSource implements FoodLocalDataSources {
  final Database database;
  final String tableName = 'foods';
  FoodSqfliteDataSource(this.database);

  /// حفظ عنصر جديد في قاعدة البيانات مع التحقق من التكرار
  @override
  Future<int> saveFood(FoodEntity food) async {
    final model = FoodSqfliteMapper.toModel(food);

    // تحقق مما إذا كان الطعام موجوداً مسبقاً بالاسم
    final existing = await database.query(
      tableName,
      where: 'name = ?',
      whereArgs: [food.name],
    );
    if (existing.isEmpty) {
      final map = model.toMap();
      if (food.id != null) {
        map['id'] = food.id;
      }
      return await database.insert(tableName, map);
    }
    return existing.first['id'] as int;
  }

  /// حذف عنصر من قاعدة البيانات
  @override
  Future<void> unsaveFood(FoodEntity food) async {
    await database.delete(tableName, where: 'id = ?', whereArgs: [food.id]);
  }

  /// جلب البيانات مع دعم البحث والصفحات
  @override
  Future<List<FoodEntity>> getSavedFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    final offset = (pageNumber - 1) * pageSize;
    // بناء شرط البحث إذا كان موجود
    String? whereClause;
    List<dynamic>? whereArgs;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      whereClause = 'name LIKE ?';
      whereArgs = ['%$searchQuery%'];
    }
    final result = await database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
      limit: pageSize,
      offset: offset,
      orderBy: 'id DESC', // أحدث عنصر أولاً
    );
    return result.map((map) {
      final model = FoodSqfliteModel.fromMap(map);
      return FoodSqfliteMapper.toEntity(model);
    }).toList();
  }

  @override
  Future<bool> isFoodSaved(FoodEntity food) async {
    final result = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [food.id],
      limit: 1, // لا نحتاج أكثر من عنصر واحد
    );
    return result.isNotEmpty; // إذا وجدت نتيجة، فالعنصر موجود
  }

  @override
  Future<FoodEntity> getFoodFormLocalDataBaseById(int id) async {
    final result = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1, // لا نحتاج أكثر من عنصر واحد
    );
    return FoodSqfliteMapper.toEntity(FoodSqfliteModel.fromMap(result.first));
  }
}
