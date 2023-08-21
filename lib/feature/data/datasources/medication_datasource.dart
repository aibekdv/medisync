import 'package:medisync/config/config.dart';
import 'package:medisync/core/error/exception.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class MedicationDataSource {
  Future<List<MedicationModel>> getAllMedications();

  Future<void> addMedication({
    required MedicationModel medication,
  });

  Future<void> deleteMedication({
    required String medicationId,
  });

  Future<void> updateMedication({
    required String medicationId,
    required Map<String, dynamic> newData,
  });
}

final class MedicationDataSourceImpl implements MedicationDataSource {
  final DatabaseService databaseService;

  MedicationDataSourceImpl({required this.databaseService});

  // Add medication to firebase
  @override
  Future<void> addMedication({
    required MedicationModel medication,
  }) async {
    try {
      Database db = await databaseService.openDB();
      await db.insert(
        'medications',
        medication.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException();
    }
  }

  // Remove medication from firebase
  @override
  Future<void> deleteMedication({
    required String medicationId,
  }) async {
    try {
      Database db = await databaseService.openDB();
      await db.delete(
        'medications',
        where: 'id = ?',
        whereArgs: [medicationId],
      );
    } catch (e) {
      throw CacheException();
    }
  }

  // Update medication in firebase
  @override
  Future<void> updateMedication({
    required String medicationId,
    required Map<String, dynamic> newData,
  }) async {
    try {
      Database db = await databaseService.openDB();
      await db.update(
        'medications',
        newData,
        where: 'id = ?',
        whereArgs: [medicationId],
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<MedicationModel>> getAllMedications() async {
    Database db = await databaseService.openDB();
    final List<Map<String, dynamic>> maps = await db.query('medications');
    return List.generate(maps.length, (i) {
      return MedicationModel(
        id: maps[i]['id'].toString(),
        name: maps[i]['name'],
        dosage: maps[i]['dosage'],
        notes: maps[i]['notes'],
        status: maps[i]['status'],
        times: parseTimesFromString(maps[i]['times']),
        selectedDays: parseSelectedDaysFromString(maps[i]['selectedDays']),
      );
    });
  }
}

class DatabaseService {
  Future<Database> openDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'my_database.db');
    Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medications (
        id INTEGER PRIMARY KEY,
        name TEXT,
        dosage TEXT,
        notes TEXT,
        times TEXT,
        status TEXT,
        selectedDays TEXT
      )
    ''');
  }
}
