import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

enum TransactionType {
  income,
  expense,
}

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
          child: _TransactionList(
            scrollController: widget.scrollController,
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
    required this.scrollController,
  });

  final ScrollController scrollController;

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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 20,
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) => StickyHeader(
              controller: scrollController,
              header: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(color: Colors.white),
                height: 32,
                child: Text(
                  _getDay(index),
                  style: const TextStyle(
                    fontSize: 17,
                    height: 22 / 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              content: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => _TransactionItem(
                  type: Random().nextBool() ? TransactionType.income : TransactionType.expense,
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getDay(int index) {
    if (index == 0) {
      return 'Сегодня';
    } else if (index == 1) {
      return 'Вчера';
    }
    final DateTime date = DateTime.now().subtract(Duration(days: index));
    return DateFormat.MMMd().format(date);
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.type,
  });
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    final Color color = type == TransactionType.income ? const Color(0xFFA0EA74) : const Color(0xFFFF6767);
    final String price = _getPrice(price: Random().nextDouble() * 1000, decimalDigits: 2);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.15),
            ),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: Icon(
              type == TransactionType.income ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  type == TransactionType.income ? 'Со счета Тинькофф' : 'На счет Тинькофф',
                  style: const TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    letterSpacing: -0.24,
                  ),
                ),
                const Text(
                  'Перевод между счетами',
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
                type == TransactionType.income ? price : '-$price',
                style: const TextStyle(
                  fontSize: 15,
                  height: 20 / 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
              const Text(
                '22.06',
                style: TextStyle(
                  fontSize: 13,
                  height: 16 / 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPrice({required double price, int decimalDigits = 0}) {
    return NumberFormat.currency(locale: 'ru', symbol: '\u20BD', decimalDigits: decimalDigits).format(price);
  }
}
