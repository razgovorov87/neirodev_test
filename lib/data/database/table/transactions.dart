import 'package:drift/drift.dart';

import '../../../domain/models/enum/transaction_type.dart';

@DataClassName('TransactionEntity')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get sum => real()();
  RealColumn get fee => real()();
  TextColumn get type => textEnum<TransactionType>()();
  DateTimeColumn get createdAt => dateTime()();
}
