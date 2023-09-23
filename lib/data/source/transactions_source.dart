import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

import '../database/dao/transactions/transactions_dao.dart';
import '../database/transaction_database.dart';

@Singleton()
class TransactionsSource {
  TransactionsSource(this._database);

  final TransactionDatabase _database;

  TransactionsDao get _transactionsDao => _database.transactionsDao;
  late final BehaviorSubject<Map<int, TransactionEntity>> _transactionStream;

  Map<int, TransactionEntity> getAcounts() => _transactionStream.value;
  Stream<Map<int, TransactionEntity>> watchAccounts() => _transactionStream;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    _transactionStream = BehaviorSubject<Map<int, TransactionEntity>>.seeded(
      _listToMap(await _transactionsDao.getTransactions()),
    );

    _transactionStream.addStream(
      _transactionsDao.watchTransactions().map(
            (List<TransactionEntity> accounts) => _listToMap(accounts),
          ),
    );
  }

  Map<int, TransactionEntity> _listToMap(List<TransactionEntity> transactions) {
    return <int, TransactionEntity>{
      for (final TransactionEntity transaction in transactions) transaction.id: transaction,
    };
  }

  Future<void> insertTransaction(TransactionEntity transaction) => _transactionsDao.insertTransaction(transaction);

  Future<void> deleteTransaction(TransactionEntity transaction) => _transactionsDao.deleteTransaction(transaction);
}
