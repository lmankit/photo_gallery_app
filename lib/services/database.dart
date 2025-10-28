import 'package:path/path.dart';
import 'package:photo_gallery_app/models/photo.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;
  static const String tableName = 'photos';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'photos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id TEXT PRIMARY KEY,
            createdAt TEXT,
            url TEXT,
            description TEXT,
            location TEXT,
            createdBy TEXT,
            takenAt TEXT
          )
        ''');
      },
    );
  }

  Future<void> cachePhotos(List<Photo> photos) async {
    final db = await database;
    Batch batch = db.batch();

    for (var photo in photos) {
      batch.insert(
        tableName,
        photo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Photo>> getCachedPhotos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => Photo.fromJson(map)).toList();
  }

  Future<void> clearCache() async {
    final db = await database;
    await db.delete(tableName);
  }
}
