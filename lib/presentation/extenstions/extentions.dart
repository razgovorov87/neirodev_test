import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../domain/models/enum/transaction_type.dart';
import '../../generated/assets.gen.dart';

extension FormatDoubleToPrice on double {
  String getPrice({int decimalDigits = 0}) {
    return NumberFormat.currency(locale: 'ru', symbol: '\u20BD', decimalDigits: decimalDigits).format(this);
  }
}

extension GetColorTransactionType on TransactionType {
  Color getColor() {
    switch (this) {
      case TransactionType.income:
        return Colors.green;
      case TransactionType.expense:
        return const Color(0xFFFF6767);
      case TransactionType.withdraw:
        return Colors.amber;
    }
  }
}

extension GetTitleTransactionType on TransactionType {
  String getTitle() {
    switch (this) {
      case TransactionType.income:
        return 'Пополнение через банкомат';
      case TransactionType.expense:
        return 'Перевод по номеру карты';
      case TransactionType.withdraw:
        return 'Снятие наличных';
    }
  }
}

extension GetIconTransactionType on TransactionType {
  SvgPicture getIcon() {
    switch (this) {
      case TransactionType.income:
        return Assets.icons.arrowUp.svg(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            TransactionType.income.getColor(),
            BlendMode.srcIn,
          ),
        );
      case TransactionType.expense:
        return Assets.icons.arrowDown.svg(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            TransactionType.expense.getColor(),
            BlendMode.srcIn,
          ),
        );
      case TransactionType.withdraw:
        return Assets.icons.withdraw.svg(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            TransactionType.withdraw.getColor(),
            BlendMode.srcIn,
          ),
        );
    }
  }
}
