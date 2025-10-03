import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteServicesProvider extends GetxService {
  late final Database database;

  Future<SqfliteServicesProvider> init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'food_database.db');

    database = await openDatabase(path, version: 1, onCreate: _onCreate);

    return this;
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createFoodsTable(db);
    await _createDietPlansTable(db);
    await _createMealsTable(db);
    await _createMealIngredientsTable(db);
  }

  Future<void> _createFoodsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        protein REAL NOT NULL,
        fat REAL NOT NULL,
        carbohydrate REAL NOT NULL,
        calories REAL NOT NULL
      )
    ''');
  }

  Future<void> _createDietPlansTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS diet_plans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createMealsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dietPlanId INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        FOREIGN KEY (dietPlanId) REFERENCES diet_plans (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _createMealIngredientsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS meal_ingredients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mealId INTEGER NOT NULL,
        weight REAL NOT NULL,
        foodId INTEGER NOT NULL,
        FOREIGN KEY (mealId) REFERENCES meals (id) ON DELETE CASCADE,
        FOREIGN KEY (foodId) REFERENCES foods (id) ON DELETE CASCADE
      )
    ''');
  }
}
