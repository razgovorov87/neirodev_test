import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/models/enum/transaction_type.dart';
import 'dao/transactions/transactions_dao.dart';
import 'table/transactions.dart';

part 'transaction_database.g.dart';

@DriftDatabase(
  tables: <Type>[
    Transactions,
  ],
  daos: <Type>[
    TransactionsDao,
  ],
)
@Singleton()
class TransactionDatabase extends _$TransactionDatabase {
  TransactionDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();

          for (final int i in <int>[0, 1, 2]) {
            final TransactionType type = TransactionType.values[i];
            final double amount = Random().nextDouble() * 1000;
            final DateTime date = DateTime.now().subtract(Duration(days: Random().nextInt(3)));
            await into(transactions).insert(
              TransactionsCompanion.insert(
                sum: type == TransactionType.income ? amount : -amount,
                fee: amount * 0.05,
                type: type,
                createdAt: date,
              ),
            );
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
