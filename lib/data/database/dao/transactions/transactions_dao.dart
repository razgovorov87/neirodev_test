import 'package:drift/drift.dart';

import '../../table/transactions.dart';
import '../../transaction_database.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: <Type>[
  Transactions,
])
class TransactionsDao extends DatabaseAccessor<TransactionDatabase> with _$TransactionsDaoMixin {
  TransactionsDao(super.db);

  Stream<List<TransactionEntity>> watchTransactions() => select(transactions).watch();

  Future<List<TransactionEntity>> getTransactions() => select(transactions).get();

  Future<void> insertTransaction(TransactionEntity transaction) => into(transactions).insert(
        TransactionsCompanion.insert(
          sum: transaction.sum,
          fee: transaction.fee,
          type: transaction.type,
          createdAt: transaction.createdAt,
        ),
      );

  Future<void> deleteTransaction(TransactionEntity transaction) => delete(transactions).delete(transaction);
}
