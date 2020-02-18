import '../../infrastructure/database/database_helper.dart';
import '../models/transaction.dart';

/// This class serves as an extra separation layer from Database Helper class
class DatabaseManager {
  // Singleton instance from Database Manager class.
  static final instance = DatabaseManager._();
  DatabaseManager._() {
    // immediately fetch transactions from the database
    getTransactionsFromDatabase();
  }
  factory DatabaseManager() => instance;

  // instance of database helper class.
  final databaseHelper = DatabaseHelper();

  List<Transaction> _transactions;
  List<Transaction> get transactions => _transactions;

  void addTransactionToDatabase(Transaction transaction) async {
    int id = await databaseHelper.insert(transaction);
    print('id of the newely add transaction: $id');
  }

  void deleteTransactionFromDatabase(int id) async {
    int count = await databaseHelper.delete(id);
    print('number of affected items in the list: $count');
  }

  void getTransactionsFromDatabase() async {
    var list = await databaseHelper.getAllTransactions();
    print('set database cached list');
    _transactions = list;
  }
}
