import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:expense_manager/domain/models/transaction.dart' as my;

// database table and column names
final String tableTransactions = 'transactions';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnAmount = 'amount';
final String columnDate = 'date';
final String columnCategory = 'category';

// The data class model is Transaction class and here is called 'my.Transaction'
// to avoid conflict with the existing Transaction class in sqflite package

// Database Helper Class
// a singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Make use of the factory constructor to ensure there is only
  // one instance of the DatabaseHelper class
  factory DatabaseHelper() => instance;

  // Only allow a single open connection to the database.
  static Database _database;
  // a getter for the _database private instance
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database or create a new one if not existed
  // by passing the onCreate callback
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    // This can be replaced by getDatabasePath() function of the sqflite plugin
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Execute SQL string to create the database for the first time
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTransactions (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnTitle TEXT NOT NULL,
                $columnAmount REAL NOT NULL,
                $columnCategory TEXT NOT NULL,
                $columnDate TEXT NOT NULL,
              )
              ''');
  }

  // Database helper methods:

  // add a transaction to the database table and return the auto-gen id for it
  Future<int> insert(my.Transaction transaction) async {
    Database db = await database;
    int id = await db.insert(tableTransactions, transaction.toMap());
    return id;
  }

  // delete a transaction with the given id
  Future<int> delete(int id) async {
    Database db = await database;
    var count = await db
        .delete(tableTransactions, where: '$columnId = ?', whereArgs: [id]);
    return count;
  }

// get a list of encoded to map transactions
  Future<List<Map<String, dynamic>>> queryAllTransactions() async {
    Database db = await database;
    var list = await db.query(tableTransactions);
    return list;
  }

  // get list of decoded  transactions
  Future<List<my.Transaction>> getAllTransactions() async {
    var maps = await queryAllTransactions();

    return maps.map((map) {
      return my.Transaction.fromMap(map);
    }).toList();
  }
} // DatabaseHelper
