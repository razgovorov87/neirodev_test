import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/get_transactions_cubit/transactions_cubit.dart';
import '../../../domain/models/enum/transaction_type.dart';
import '../../../domain/models/transaction/transaction.dart';
import '../../design/transaction_type/transaction_type_icon.dart';
import '../../extenstions/extentions.dart';
import 'widgets/pie_chart.dart';

@RoutePage()
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (BuildContext context, TransactionsState state) {
        final List<Transaction> transactions = state.transactions;
        final double total = _getTotal(transactions);
        final Map<TransactionType, double> map = _getData(transactions);

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppPieChart(
                map: map,
                total: total,
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: map.length,
                itemBuilder: (BuildContext context, int index) {
                  final MapEntry<TransactionType, double> item = map.entries.elementAt(index);

                  return _ListItem(item: item);
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<TransactionType, double> _getData(List<Transaction> transactions) {
    final Map<TransactionType, double> map = <TransactionType, double>{
      TransactionType.income: 0,
      TransactionType.expense: 0,
      TransactionType.withdraw: 0,
    };

    for (final Transaction item in transactions) {
      map[item.type] = (map[item.type] ?? 0) + (item.sum.abs() + item.fee);
    }

    return map;
  }

  double _getTotal(List<Transaction> list) {
    double total = 0;
    for (final Transaction i in list) {
      total += i.type == TransactionType.income ? i.sum + i.fee : i.sum - i.fee;
    }
    return total;
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.item,
  });

  final MapEntry<TransactionType, double> item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TransactionTypeIcon(transactionType: item.key),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            item.key.parseType(),
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: -0.24,
            ),
          ),
        ),
        Text(
          item.value.getPrice(decimalDigits: 2),
          style: const TextStyle(
            fontSize: 15,
            height: 20 / 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.24,
          ),
        ),
      ],
    );
  }
}
