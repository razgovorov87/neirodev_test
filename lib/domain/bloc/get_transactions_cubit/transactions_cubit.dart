import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/transaction/transaction.dart';
import '../../repository/transactions_repository.dart';

part 'transactions_cubit.freezed.dart';
part 'transactions_state.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(
    this._transactionsRepository,
  ) : super(
          TransactionsState(transactions: _transactionsRepository.getAllTransactions()),
        ) {
    _streamSubscription = _transactionsRepository.watchAllTransaction().listen(
      (List<Transaction> transactions) {
        emit(TransactionsState(transactions: transactions));
      },
    );
  }

  late final StreamSubscription<List<Transaction>> _streamSubscription;
  final TransactionsRepository _transactionsRepository;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();

    return super.close();
  }
}
