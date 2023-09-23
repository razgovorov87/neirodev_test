part of 'transactions_cubit.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    required List<Transaction> transactions,
  }) = _TransactionsState;
}
