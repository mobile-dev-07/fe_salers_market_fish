import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/sold_category_data.dart'; // Model data, pastikan di-import kalau dipisah file

class MostSoldBarChart extends StatelessWidget {
  final List<SoldCategoryData> data;

  const MostSoldBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(data),
          gridData: FlGridData(show: true),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  if (value.toInt() < data.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        data[value.toInt()].name,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            data.length,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index].value,
                  color: Colors.green,
                  width: 18,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxY(List<SoldCategoryData> data) {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return (maxValue + 10).ceilToDouble();
  }
}
