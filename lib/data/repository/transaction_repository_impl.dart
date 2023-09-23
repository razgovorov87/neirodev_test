import 'package:injectable/injectable.dart';

import '../../domain/models/transaction/transaction.dart';
import '../../domain/repository/transactions_repository.dart';
import '../database/mapper/transaction_mapper.dart';
import '../database/transaction_database.dart';
import '../source/transactions_source.dart';

@Singleton(as: TransactionsRepository)
class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(
    this._transactionsSource,
  );

  final TransactionsSource _transactionsSource;

  @override
  Stream<List<Transaction>> watchAllTransaction() => _transactionsSource.watchAccounts().map(
        (Map<int, TransactionEntity> entry) => entry.values.map(TransactionMapper.toDomain).toList(),
      );

  @override
  List<Transaction> getAllTransactions() =>
      _transactionsSource.getAcounts().values.map(TransactionMapper.toDomain).toList();

  @override
  Future<void> addTransaction(Transaction transaction) =>
      _transactionsSource.insertTransaction(TransactionMapper.toEntity(transaction));

  @override
  Future<void> removeTransaction(Transaction transaction) =>
      _transactionsSource.deleteTransaction(TransactionMapper.toEntity(transaction));
}
