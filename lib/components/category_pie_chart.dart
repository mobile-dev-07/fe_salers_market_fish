
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/pie_category_data.dart';

class CategoryPieChart extends StatelessWidget {
  final List<PieCategoryData> data;

  const CategoryPieChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = data.fold(0.0, (sum, item) => sum + item.value);

    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: data.map((item) {
                  final percent = (item.value / total * 100).toStringAsFixed(1);
                  return PieChartSectionData(
                    value: item.value,
                    color: item.color,
                    title: '$percent%',
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: data.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 12, height: 12, color: item.color),
                  const SizedBox(width: 6),
                  Text(item.label),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}