import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/transaction_type.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    @Default(-1) int id,
    required double sum,
    required double fee,
    required TransactionType type,
    required DateTime createdAt,
  }) = _Transaction;
}
