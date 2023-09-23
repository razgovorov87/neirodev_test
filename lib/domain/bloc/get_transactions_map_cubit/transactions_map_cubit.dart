import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/transaction/transaction.dart';
import '../../repository/transactions_repository.dart';

part 'transactions_map_cubit.freezed.dart';
part 'transactions_map_state.dart';

@injectable
class TransactionsMapCubit extends Cubit<TransactionsMapState> {
  TransactionsMapCubit(
    this._transactionsRepository,
  ) : super(
          const TransactionsMapState(transactions: <DateTime, List<Transaction>>{}),
        ) {
    _streamSubscription = _transactionsRepository.watchAllTransaction().listen(
      (List<Transaction> transactions) {
        emit(TransactionsMapState(transactions: _toMap(transactions)));
      },
    );
  }

  Map<DateTime, List<Transaction>> _toMap(List<Transaction> transactions) {
    final Map<DateTime, List<Transaction>> map = <DateTime, List<Transaction>>{};
    final Map<DateTime, List<Transaction>> result = <DateTime, List<Transaction>>{};

    for (final Transaction item in transactions) {
      final DateTime createdAt = item.createdAt;
      final DateTime date = DateTime(createdAt.year, createdAt.month, createdAt.day);
      if (map[date] != null) {
        map[date] = <Transaction>[...map[date]!, item];
      } else {
        map[date] = <Transaction>[item];
      }
    }

    final List<DateTime> keys = map.keys.sorted((DateTime a, DateTime b) => b.compareTo(a));
    for (final DateTime key in keys) {
      result[key] = map[key]!;
    }

    return result;
  }

  late final StreamSubscription<List<Transaction>> _streamSubscription;
  final TransactionsRepository _transactionsRepository;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();

    return super.close();
  }
}
