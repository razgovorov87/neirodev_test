import 'package:flutter/material.dart';

import '../../../domain/models/enum/transaction_type.dart';
import '../../extenstions/extentions.dart';

class TransactionTypeIcon extends StatelessWidget {
  const TransactionTypeIcon({
    super.key,
    required this.transactionType,
  });

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: transactionType.getColor().withOpacity(0.15),
      ),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      height: 40,
      width: 40,
      child: transactionType.getIcon(),
    );
  }
}
