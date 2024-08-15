import 'dart:async';
import 'dart:io';

import 'package:blog_explorer/models/blog_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "Blog.db";
  static const _databaseVersion = 1;

  static const _table = "favourite";

  static const _columnId = "id";
  static const _columnImageUrl = "image_url";
  static const _columnTitle = "title";

  // for singleton pattern
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //only have one instance
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    Create Table $_table(
    $_columnId TEXT  NOT NULL PRIMARY KEY,
    $_columnImageUrl Text NOT NULL,
    $_columnTitle TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertBlog(BlogModel blogModel) async {
    try {
      Database db = await instance.database;
      return await db.insert(_table, blogModel.toJson());
    } catch (e) {
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllFavoriteBlogs() async {
    Database db = await instance.database;
    return await db.query(_table);
  }
}
