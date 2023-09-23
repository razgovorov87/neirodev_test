import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../domain/bloc/add_remove_transactions_bloc/add_remove_transactions_bloc.dart';
import '../../../../domain/bloc/get_transactions_cubit/transactions_cubit.dart';
import '../../../../domain/models/enum/transaction_type.dart';
import '../../../../domain/models/transaction/transaction.dart';
import '../../../../generated/assets.gen.dart';
import '../../../extenstions/extentions.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text(
            'Главная',
            style: TextStyle(
              fontSize: 24,
              height: 28 / 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 26),
          BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (BuildContext context, TransactionsState state) {
              final List<Transaction> list = state.transactions;
              double total = 0;
              for (final Transaction i in list) {
                total += i.sum + i.fee;
              }
              return _TotalAmount(total: total);
            },
          ),
          const SizedBox(height: 46),
          const _ActionRowWidget(),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}

class _ActionRowWidget extends StatelessWidget {
  const _ActionRowWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          _ActionItem(
            onTap: () {
              context.read<AddRemoveTransactionsBloc>().add(
                    const AddRemoveTransactionsEvent.addTransaction(TransactionType.income),
                  );
            },
            icon: Assets.icons.addCircle.svg(),
            text: 'Пополнить',
          ),
          _ActionItem(
            onTap: () {
              context.read<AddRemoveTransactionsBloc>().add(
                    const AddRemoveTransactionsEvent.addTransaction(TransactionType.expense),
                  );
            },
            icon: Assets.icons.transferCircle.svg(),
            text: 'Перевести',
          ),
          _ActionItem(
            onTap: () {
              context.read<AddRemoveTransactionsBloc>().add(
                    const AddRemoveTransactionsEvent.addTransaction(TransactionType.withdraw),
                  );
            },
            icon: Assets.icons.minusCircle.svg(),
            text: 'Снять',
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.onTap,
    required this.icon,
    required this.text,
  });

  final VoidCallback onTap;
  final SvgPicture icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  height: 16 / 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount({
    required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Tinkoff Black',
                style: TextStyle(
                  fontSize: 13,
                  height: 16 / 13,
                ),
              ),
              Text(
                total.getPrice(),
                style: const TextStyle(
                  fontSize: 24,
                  height: 28 / 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF99DBF8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('RUB'),
        ),
      ],
    );
  }
}
