import '../models/transaction/transaction.dart';

abstract class TransactionsRepository {
  Stream<List<Transaction>> watchAllTransaction();

  List<Transaction> getAllTransactions();

  Future<void> addTransaction(Transaction transaction);

  Future<void> removeTransaction(Transaction transaction);
}
