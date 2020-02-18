import '../../infrastructure/database/database_helper.dart';

/// This class serves as an extra separation layer from DatabaseHelper class
class DatabaseManager {
  static final instance = DatabaseManager._();

  DatabaseManager._() {
    // initialize DatabaseHelper class
  }

  factory DatabaseManager() => instance;

  // methods to get data from database helpers

}
