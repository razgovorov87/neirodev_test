import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/enum/operation_type.dart';
import '../../models/enum/transaction_type.dart';
import '../../models/transaction/transaction.dart';
import '../../repository/transactions_repository.dart';

part 'add_remove_transactions_bloc.freezed.dart';

@injectable
class AddRemoveTransactionsBloc extends Bloc<AddRemoveTransactionsEvent, AddRemoveTransactionsState> {
  AddRemoveTransactionsBloc(
    this._transactionsRepository,
  ) : super(const AddRemoveTransactionsState.initial()) {
    on<AddRemoveTransactionsEvent>(_onEvent);
  }

  final TransactionsRepository _transactionsRepository;

  FutureOr<void> _onEvent(AddRemoveTransactionsEvent mainEvent, Emitter<AddRemoveTransactionsState> emit) =>
      mainEvent.map(
        addTransaction: (_AddTransaction event) => _mapAddTransactionToState(event, emit),
        removeTransaction: (_RemoveTransaction event) => _mapRemoveTransactionToState(event, emit),
      );

  Future<void> _mapAddTransactionToState(_AddTransaction event, Emitter<AddRemoveTransactionsState> emit) async {
    try {
      final TransactionType type = event.type;
      final double sum = Random().nextDouble() * 1000;

      final Transaction transaction = Transaction(
        sum: type == TransactionType.income ? sum : -sum,
        fee: sum * 0.05,
        type: type,
        createdAt: DateTime.now(),
      );

      await _transactionsRepository.addTransaction(transaction);
      emit(const AddRemoveTransactionsState.success(OperationType.add));
    } catch (e) {
      emit(AddRemoveTransactionsState.error(e.toString()));
    }
  }

  Future<void> _mapRemoveTransactionToState(_RemoveTransaction event, Emitter<AddRemoveTransactionsState> emit) async {
    try {
      final Transaction transaction = event.transaction;

      await _transactionsRepository.removeTransaction(transaction);
      emit(const AddRemoveTransactionsState.success(OperationType.remove));
    } catch (e) {
      emit(AddRemoveTransactionsState.error(e.toString()));
    }
  }
}

@freezed
class AddRemoveTransactionsEvent with _$AddRemoveTransactionsEvent {
  const factory AddRemoveTransactionsEvent.addTransaction(TransactionType type) = _AddTransaction;

  const factory AddRemoveTransactionsEvent.removeTransaction(Transaction transaction) = _RemoveTransaction;
}

@freezed
class AddRemoveTransactionsState with _$AddRemoveTransactionsState {
  const factory AddRemoveTransactionsState.initial() = _Initial;

  const factory AddRemoveTransactionsState.waiting() = _Waiting;

  const factory AddRemoveTransactionsState.success(OperationType type) = _Success;

  const factory AddRemoveTransactionsState.error(String message) = _Error;
}
