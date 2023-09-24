import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/enum/transaction_type.dart';
import '../../../extenstions/extentions.dart';

class AppPieChart extends StatefulWidget {
  const AppPieChart({
    super.key,
    required this.map,
    required this.total,
  });

  final Map<TransactionType, double> map;
  final double total;

  @override
  State<AppPieChart> createState() => _AppPieChartState();
}

class _AppPieChartState extends State<AppPieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      height: 217,
      child: Stack(
        children: <Widget>[
          _Chart(
            total: widget.total,
            map: widget.map,
          ),
          Align(
            child: _CenterWidget(
              total: widget.total,
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterWidget extends StatelessWidget {
  const _CenterWidget({
    required this.total,
  });
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 173,
      width: 173,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            color: const Color(0xFF1d2041).withOpacity(0.1),
          ),
        ],
      ),
      child: Text(
        total.getPrice(decimalDigits: 2),
        style: const TextStyle(
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.map,
    required this.total,
  });

  final Map<TransactionType, double> map;
  final double total;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 86,
        sectionsSpace: 0,
        sections: <PieChartSectionData>[
          if (total != 0)
            ...map.entries.map(
              (MapEntry<TransactionType, double> entry) => PieChartSectionData(
                value: entry.value / total,
                radius: 22,
                color: entry.key.getColor(),
                showTitle: false,
              ),
            )
          else
            PieChartSectionData(
              value: 100,
              radius: 22,
              color: Colors.grey.shade300,
              showTitle: false,
            ),
        ],
      ),
      swapAnimationDuration: const Duration(milliseconds: 100),
    );
  }
}
