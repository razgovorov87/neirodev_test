import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../generated/assets.gen.dart';

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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Главная',
            style: TextStyle(
              fontSize: 24,
              height: 28 / 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 26),
          _TotalAmount(),
          SizedBox(height: 46),
          _ActionRowWidget(),
          SizedBox(height: 36),
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
            onTap: () {},
            icon: Assets.icons.addCircle.svg(),
            text: 'Пополнить',
          ),
          _ActionItem(
            onTap: () {},
            icon: Assets.icons.minusCircle.svg(),
            text: 'Потратить',
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
  const _TotalAmount();

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
                _getPrice(price: 1204564.36, decimalDigits: 2),
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

  String _getPrice({required double price, int decimalDigits = 0}) {
    return NumberFormat.currency(locale: 'ru', symbol: '\u20BD', decimalDigits: decimalDigits).format(price);
  }
}
