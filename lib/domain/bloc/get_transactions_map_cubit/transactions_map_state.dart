part of 'transactions_map_cubit.dart';

@freezed
class TransactionsMapState with _$TransactionsMapState {
  const factory TransactionsMapState({
    required Map<DateTime, List<Transaction>> transactions,
  }) = _TransactionsMapState;
}
