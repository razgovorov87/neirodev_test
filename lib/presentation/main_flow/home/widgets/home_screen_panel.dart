import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../domain/bloc/get_transactions_map_cubit/transactions_map_cubit.dart';
import '../../../../domain/models/transaction/transaction.dart';
import '../../../design/transaction_type/transaction_type_icon.dart';
import '../../../extenstions/extentions.dart';
import '../../../router/router.gr.dart';

class HomeScreenPanel extends StatefulWidget {
  const HomeScreenPanel({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<HomeScreenPanel> createState() => _HomeScreenPanelState();
}

class _HomeScreenPanelState extends State<HomeScreenPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          child: BlocBuilder<TransactionsMapCubit, TransactionsMapState>(
            builder: (BuildContext context, TransactionsMapState state) {
              final Map<DateTime, List<Transaction>> map = state.transactions;

              return _TransactionList(
                map: map,
                scrollController: widget.scrollController,
              );
            },
          ),
        ),
        Positioned(
          top: 6,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 4,
              width: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({
    required this.map,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final Map<DateTime, List<Transaction>> map;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 26),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'История операций',
            style: TextStyle(
              fontSize: 20,
              height: 26 / 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: map.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: map.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int keyIndex) {
                    final MapEntry<DateTime, List<Transaction>> currentEntry = map.entries.elementAt(keyIndex);
                    final DateTime date = currentEntry.key;
                    final List<Transaction> transactions =
                        currentEntry.value.sorted((Transaction a, Transaction b) => b.createdAt.compareTo(a.createdAt));

                    return StickyHeader(
                      controller: scrollController,
                      header: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 6),
                        decoration: const BoxDecoration(color: Colors.white),
                        height: 32,
                        child: Text(
                          _getDate(date),
                          style: const TextStyle(
                            fontSize: 17,
                            height: 22 / 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      content: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: transactions.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) => _TransactionItem(
                          transaction: transactions[index],
                        ),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 6),
                      ),
                    );
                  },
                )
              : Container(
                  padding: const EdgeInsets.only(top: 16),
                  alignment: Alignment.topCenter,
                  child: const Text('Нет операций'),
                ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String _getDate(DateTime day) {
    final DateFormat pattern = DateFormat.MMMMd();
    return pattern.format(day);
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.transaction,
  });
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(TransactionInfoDialog(transaction: transaction));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            TransactionTypeIcon(transactionType: transaction.type),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    transaction.type.getTitle(),
                    style: const TextStyle(
                      fontSize: 15,
                      height: 20 / 15,
                      letterSpacing: -0.24,
                    ),
                  ),
                  const Text(
                    'Переводы',
                    style: TextStyle(
                      fontSize: 13,
                      height: 16 / 13,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  transaction.sum.getPrice(decimalDigits: 2),
                  style: const TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.24,
                  ),
                ),
                Text(
                  _getCreatedAt(transaction.createdAt),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 16 / 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCreatedAt(DateTime createdAt) {
    final DateFormat pattern = DateFormat.Hm();
    return pattern.format(createdAt);
  }
}
