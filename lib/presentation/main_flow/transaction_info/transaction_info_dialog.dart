import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/bloc/add_remove_transactions_bloc/add_remove_transactions_bloc.dart';
import '../../../domain/models/transaction/transaction.dart';
import '../../../generated/assets.gen.dart';
import '../../../injectable.dart';
import '../../extenstions/extentions.dart';

@RoutePage()
class TransactionInfoDialog extends StatefulWidget {
  const TransactionInfoDialog({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  State<TransactionInfoDialog> createState() => _TransactionInfoDialogState();
}

class _TransactionInfoDialogState extends State<TransactionInfoDialog> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: screenSize.width * 0.82,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _InfoWidget(transaction: widget.transaction),
              const SizedBox(height: 16),
              _CancelButton(transaction: widget.transaction),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatefulWidget {
  const _CancelButton({
    required this.transaction,
  });

  final Transaction transaction;

  @override
  State<_CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<_CancelButton> {
  late AddRemoveTransactionsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<AddRemoveTransactionsBloc>();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _bloc.add(
          AddRemoveTransactionsEvent.removeTransaction(widget.transaction),
        );
        context.router.pop();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Assets.icons.refresh.svg(
              colorFilter: const ColorFilter.mode(
                Colors.red,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Отменить',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 20 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget({
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final double total = transaction.sum + transaction.fee;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(16, 52, 16, 24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              const Text(
                'Переводы',
                style: TextStyle(
                  fontSize: 13,
                  height: 16 / 13,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                total.getPrice(decimalDigits: 2),
                style: const TextStyle(
                  fontSize: 24,
                  height: 28 / 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                transaction.type.getTitle(),
                style: const TextStyle(
                  fontSize: 15,
                  height: 20 / 15,
                  letterSpacing: -0.24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _getDate(transaction.createdAt),
                style: TextStyle(
                  fontSize: 13,
                  height: 16 / 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -25,
          left: 0,
          right: 0,
          child: _Icon(transaction: transaction),
        ),
      ],
    );
  }

  String _getDate(DateTime createdAt) {
    final DateFormat pattern = DateFormat('dd.MM.yyyy');
    return pattern.format(createdAt);
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(width: 6, color: Colors.white),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: transaction.type.getColor().withOpacity(0.15),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: transaction.type.getIcon(),
          ),
        ),
      ),
    );
  }
}
