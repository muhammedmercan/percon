import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percon/domain/models/travel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'travel_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE travels(
        id TEXT PRIMARY KEY,
        title TEXT,
        country TEXT,
        region TEXT,
        startDate TEXT,
        endDate TEXT,
        category TEXT,
        description TEXT,
        isFavorite INTEGER
      )
    ''');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      await loadInitialData(db);
      await prefs.setBool('isFirstRun', false);
    }
  }

  Future<void> loadInitialData(Database db) async {
    try {
      String jsonString = await rootBundle.loadString('assets/travels.json');
      List<dynamic> jsonList = json.decode(jsonString);

      Batch batch = db.batch();

      for (var item in jsonList) {
        Travel travel = Travel.fromJson(item);
        batch.insert('travels', travel.toMap());
      }

      await batch.commit(noResult: true);
    } catch (e) {
      // ignore: empty_catches
    }
  }

  List<Travel> _mapListToTravels(List<Map<String, dynamic>> maps) {
    return maps
        .map((m) => Travel(
              id: m['id'],
              title: m['title'],
              country: m['country'],
              region: m['region'],
              startDate: m['startDate'],
              endDate: m['endDate'],
              category: m['category'],
              description: m['description'],
              isFavorite: m['isFavorite'] == 1,
            ))
        .toList();
  }

  Map<String, dynamic> _buildWhereClause({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
  }) {
    String where = '';
    List<dynamic> args = [];

    void addCondition(String condition, dynamic value) {
      if (where.isNotEmpty) where += ' AND ';
      where += condition;
      args.add(value);
    }

    if (country != null) addCondition('country = ?', country);
    if (region != null) addCondition('region = ?', region);
    if (category != null) addCondition('category = ?', category);
    if (startDate != null) addCondition('startDate >= ?', startDate);
    if (endDate != null) addCondition('endDate <= ?', endDate);

    return {
      'where': where.isEmpty ? null : where,
      'args': args.isEmpty ? null : args
    };
  }

  Future<List<Travel>> getTravelsWithPagination(int offset, int limit) async {
    final db = await database;
    final maps = await db.query('travels', limit: limit, offset: offset);
    return _mapListToTravels(maps);
  }

  Future<int> getTotalTravelCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM travels');
    return result.first['count'] as int;
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    final db = await database;
    await db.update('travels', {'isFavorite': isFavorite ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Travel>> getFavoriteTravels() async {
    final db = await database;
    final maps =
        await db.query('travels', where: 'isFavorite = ?', whereArgs: [1]);
    return _mapListToTravels(maps);
  }

  Future<List<Travel>> getTravelsWithFiltersAndPagination({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
    int offset = 0,
    int limit = 10,
  }) async {
    final db = await database;
    final filter = _buildWhereClause(
      country: country,
      region: region,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );

    final maps = await db.query(
      'travels',
      where: filter['where'],
      whereArgs: filter['args'],
      limit: limit,
      offset: offset,
    );
    return _mapListToTravels(maps);
  }

  Future<int> getFilteredTravelCount({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    final db = await database;
    final filter = _buildWhereClause(
      country: country,
      region: region,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM travels${filter['where'] != null ? ' WHERE ${filter['where']}' : ''}',
      filter['args'],
    );

    return result.first['count'] as int;
  }

  Future<List<String>> getAllCountries() async {
    final db = await database;
    final maps = await db
        .rawQuery('SELECT DISTINCT country FROM travels ORDER BY country');
    return maps.map((map) => map['country'] as String).toList();
  }

  Future<List<String>> getAllRegions() async {
    final db = await database;
    final maps = await db
        .rawQuery('SELECT DISTINCT region FROM travels ORDER BY region');
    return maps.map((map) => map['region'] as String).toList();
  }

  Future<List<String>> getAllCategories() async {
    final db = await database;
    final maps = await db
        .rawQuery('SELECT DISTINCT category FROM travels ORDER BY category');
    return maps.map((map) => map['category'] as String).toList();
  }
}
