//my imports
import './models/transaction.dart';

abstract class ManagerDatabaseContract {
  void saveTXList();
  List<Transaction> loadTXList();
}
