import 'dart:convert';

import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<void> initializeDatabase() async {
    _db ??= await _initDb();
  }

  Future<Database> _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'hamrah_salamt.db');

    // Open the database
    Database db = await openDatabase(path, version: 1);

    // Check if the Targets table exists
    bool targetsTableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='Targets';").then((value) => value.isNotEmpty);
    if (!targetsTableExists) {
      await db.execute(
        '''
        CREATE TABLE Targets (
          id INTEGER PRIMARY KEY,
          title TEXT,
          image_url TEXT,
          category TEXT,
          tags TEXT,
          reminders TEXT,
          target_days TEXT,
          start_date TEXT,
          end_date TEXT,
          description TEXT,
          todos TEXT
        )
      ''',
      );
    }

    // Check if the DietPlan table exists
    bool dietPlanTableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='DietPlan';").then((value) => value.isNotEmpty);
    if (!dietPlanTableExists) {
      await db.execute(
        '''
        CREATE TABLE DietPlan (
          id INTEGER PRIMARY KEY,
          start_date TEXT,
          end_date TEXT,
          editable INTEGER,
          diet_plan_days TEXT
        )
      ''',
      );
    }

    bool userTableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='User';").then((value) => value.isNotEmpty);
    if (!userTableExists) {
      await db.execute(
        '''
        CREATE TABLE User (
          fullname TEXT,
          image_url TEXT,
          height REAL,
          weight REAL
        )
      ''',
      );
    }

    bool introductionScreenTableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='IntroductionScrenn';").then((value) => value.isNotEmpty);
    if (!introductionScreenTableExists) {
      await db.execute(
        '''
        CREATE TABLE IntroductionScrenn (
          login INTEGER,
          diet_planning INTEGER,
          targeting INTEGER,
          intro INTEGER
        )
      ''',
      );
    }

    return db;
  }

  // Create operation for IntroductionScrenn
  Future<int> insertIntoIntroductionScrenn(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.insert('IntroductionScrenn', row);
  }

  // Read operation for IntroductionScrenn
  Future<Map<String, dynamic>> queryRowIntroductionScrenn() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> rows = await dbClient.query('IntroductionScrenn');

    if (rows.isNotEmpty) {
      Map<String, dynamic> row = rows.first;
      Map<String, dynamic> modifiedRow = Map.from(row);
      return modifiedRow;
    } else {
      return {};
    }
  }

  // Create operation for User
  Future<int> insertIntoUser(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.insert('User', row);
  }

  // Update operation for User
  Future<void> updateUser(Map<String, dynamic> newData) async {
    Database dbClient = await db;
    await dbClient.update(
      'User',
      newData,
      where: '1', // This will update all rows since there's no specific condition
    );
  }

  // Read operation for User
  Future<Map<String, dynamic>> queryRowUser() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> rows = await dbClient.query('User');

    if (rows.isNotEmpty) {
      Map<String, dynamic> row = rows.first;
      Map<String, dynamic> modifiedRow = Map.from(row);
      return modifiedRow;
    } else {
      return {};
    }
  }

  // Create operation for DietPlan
  Future<int> insertIntoDietPlan(Map<String, dynamic> row) async {
    Database dbClient = await db;
    row['diet_plan_days'] = jsonEncode(row['diet_plan_days']);
    return await dbClient.insert('DietPlan', row);
  }

  // Read operation for DietPlan
  Future<Map<String, dynamic>> queryRowDietPlan() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> rows = await dbClient.query('DietPlan');

    if (rows.isNotEmpty) {
      Map<String, dynamic> row = rows.first;
      Map<String, dynamic> modifiedRow = Map.from(row); // Create a new modifiable map
      modifiedRow['diet_plan_days'] = jsonDecode(row['diet_plan_days']);
      return modifiedRow;
    } else {
      return {}; // Return an empty map or handle the case when no rows are found
    }
  }

  // Update operation for DietPlan
  Future<int> updateDietPlan(Map<String, dynamic> updatedRow) async {
    Database dbClient = await db;
    updatedRow['diet_plan_days'] = jsonEncode(updatedRow['diet_plan_days']);
    int id = updatedRow['id'];
    updatedRow.remove('id');
    // Perform the update operation
    return await dbClient.update('DietPlan', updatedRow, where: 'id = ?', whereArgs: [id]);
  }

  // Delete operation for DietPlan based on a specific date
  Future<int> deleteFromDietPlan(String date) async {
    Database dbClient = await db;
    return await dbClient.delete(
      'DietPlan',
      where: 'start_date = ? OR end_date = ?',
      whereArgs: [date, date],
    );
  }

  // Create operation for Targets
  Future<int> insertIntoTargets(Map<String, dynamic> row) async {
    Database dbClient = await db;
    row['tags'] = jsonEncode(row['tags']);
    row['reminders'] = jsonEncode(row['reminders']);
    row['target_days'] = jsonEncode(row['target_days']);
    row['todos'] = jsonEncode(row['todos']);

    return await dbClient.insert('Targets', row);
  }

  // Read operation for Targets
  Future<List<Map<String, dynamic>>> queryAllRowsTargets() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> rows = await dbClient.query('Targets');

    List<Map<String, dynamic>> modifiedRows = [];

    for (var row in rows) {
      Map<String, dynamic> modifiedRow = Map.from(row); // Create a modifiable copy
      modifiedRow['tags'] = jsonDecode(row['tags']);
      modifiedRow['reminders'] = jsonDecode(row['reminders']);
      modifiedRow['target_days'] = jsonDecode(row['target_days']);
      modifiedRow['todos'] = jsonDecode(row['todos']);

      modifiedRows.add(modifiedRow);
    }

    return modifiedRows;
  }

  // Update operation for TargetDays
  Future<void> updateTargetDays(int id, List<TargetDay> targetDays) async {
    // Get a reference to the database
    final Database dbClient = await _initDb();

    String targetDaysJson = jsonEncode(targetDays.map((day) => day.toJson()).toList());

    // Update the target_days column for the specified id
    await dbClient.update(
      'Targets',
      {'target_days': targetDaysJson},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update operation for TargetTodos
  Future<int> updateTargetTodos(int id, List<Todo> todos) async {
    Database dbClient = await db;

    String todosJson = jsonEncode(todos.map((todo) => todo.toJson()).toList());

    // Prepare the update query
    Map<String, dynamic> row = {
      'todos': todosJson,
    };

    return await dbClient.update(
      'Targets',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'hamrah_salamt.db');
    await deleteDatabase(path);
  }

  Future<void> closeDB() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
