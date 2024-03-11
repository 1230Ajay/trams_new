// database_helper.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


import '../entities/database.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    sqfliteFfiInit();

    // Set the databaseFactory for sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await createTables(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Handle database upgrades if needed
      },
    );

    // Check if tables already exist, and if not, create them
    if (!(await tableExists(database, 'Zone') &&
        await tableExists(database, 'Division') &&
        await tableExists(database, 'Section'))) {
      await createTables(database);
    }

    return database;
  }

  Future<void> createTables(Database db) async {
    await db.execute('''
    CREATE TABLE Zone (
      id INTEGER PRIMARY KEY,
      name TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE Division (
      id INTEGER PRIMARY KEY,
      name TEXT,
      zoneId INTEGER,
      FOREIGN KEY (zoneId) REFERENCES Zone (id)
    )
  ''');
    await db.execute('''
    CREATE TABLE Section (
      id INTEGER PRIMARY KEY,
      name TEXT,
      divisionId INTEGER,
      FOREIGN KEY (divisionId) REFERENCES Division (id)
    )
  ''');
  }

  Future<bool> tableExists(Database db, String tableName) async {
    var result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }


  Future<void> insertZone(ZoneEntity zone) async {
    final Database db = await database;
    await db.insert('Zone', zone.toMap());
  }

  Future<void> insertDivision(
      {required DivisionEntity division, required String zoneName}) async {
    final Database db = await database;

    // Find the zoneId based on the zoneName
    final List<Map<String, dynamic>> zoneResult = await db.query(
      'Zone',
      where: 'name = ?',
      whereArgs: [zoneName],
    );

    if (zoneResult.isNotEmpty) {
      final int zoneId = zoneResult.first['id'];

      // Insert the division with the zoneId
      await db.insert('Division', {
        'name': division.name,
        'zoneId': zoneId,
      });
    }
  }

  Future<void> insertSection(
      {required SectionEntity section, required String divisionName}) async {
    final Database db = await database;

    // Find the divisionId based on the divisionName
    final List<Map<String, dynamic>> divisionResult = await db.query(
      'Division',
      where: 'name = ?',
      whereArgs: [divisionName],
    );

    if (divisionResult.isNotEmpty) {
      final int divisionId = divisionResult.first['id'];

      // Insert the section with the divisionId
      await db.insert('Section', {
        'name': section.name,
        'divisionId': divisionId,
      });
    }
  }



  Future<List<ZoneEntity>> getAllZones() async {
    final Database db = await database;
    List<Map<String, dynamic>> zones = await db.query('Zone');
    return zones.map((zone) => ZoneEntity.fromMap(zone)).toList();
  }

  Future<List<DivisionEntity>> getDivisionsForZone(String zoneName) async {
    final Database db = await database;

    final List<Map<String, dynamic>> zoneResult = await db.query(
      'Zone',
      where: 'name = ?',
      whereArgs: [zoneName],
    );

    if (zoneResult.isNotEmpty) {
      final int zoneId = zoneResult.first['id'];

      List<Map<String, dynamic>> divisions = await db.query(
        'Division',
        where: 'zoneId = ?',
        whereArgs: [zoneId],
      );

      return divisions.map((division) => DivisionEntity.fromMap(division)).toList();
    }

    return [];
  }

  Future<List<SectionEntity>> getSectionsForDivision(String divisionName) async {
    final Database db = await database;

    final List<Map<String, dynamic>> divisionResult = await db.query(
      'Division',
      where: 'name = ?',
      whereArgs: [divisionName],
    );

    if (divisionResult.isNotEmpty) {
      final int divisionId = divisionResult.first['id'];

      List<Map<String, dynamic>> sections = await db.query(
        'Section',
        where: 'divisionId = ?',
        whereArgs: [divisionId],
      );

      return sections.map((section) => SectionEntity.fromMap(section)).toList();
    }

    return [];
  }


}

