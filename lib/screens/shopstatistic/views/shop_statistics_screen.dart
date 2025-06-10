import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../components/category_pie_chart.dart';
import '../../../components/last_order.dart';
import '../../../components/most_sold_bar_chart.dart';
import '../../../components/stat_card.dart';
import '../../../models/pie_category_data.dart';
import '../../../models/sold_category_data.dart';

class ShopStatisticsScreen extends StatelessWidget {
  const ShopStatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Your Shop Statistic',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth ~/ 180;
                crossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount;

                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2, // ✅ Rasio lebar/tinggi
                  children: const [
                    StatCard(
                      icon: Icons.attach_money,
                      label: 'Products Sold',
                      value: 'Rp. 12,750',
                      color: Colors.orange,
                    ),
                    StatCard(
                      icon: Icons.event,
                      label: 'Booking Success',
                      value: '750',
                      color: Colors.cyan,
                    ),
                    StatCard(
                      icon: Icons.account_balance_wallet,
                      label: 'Income',
                      value: 'Rp. 12,750',
                      color: Colors.blue,
                    ),
                    StatCard(
                      icon: Icons.cancel,
                      label: 'Booking Canceled',
                      value: '750',
                      color: Colors.pinkAccent,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            const Text('Last Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const LastOrder(
              title: 'Ikan Kerapu size M ditangkap pagi ini masih fress',
              subtitle: 'Kerapu',
              imagePath: 'assets/images/fish_1.jpeg',
            ),
            const LastOrder(
              title: 'Ikan Kerapu size XL ditangkap pagi ini masih fress',
              subtitle: 'Kakap',
              imagePath: 'assets/images/fish_2.jpeg',
            ),
            const SizedBox(height: 24),
            const Text('Most Sold Category Product', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            MostSoldBarChart(
              data: [
                SoldCategoryData('Cakalang', 55),
                SoldCategoryData('Kerapu', 65),
                SoldCategoryData('Kakap Merah', 19),
                SoldCategoryData('Bawal', 45),
                SoldCategoryData('Kepiting', 10),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Most Sold Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            CategoryPieChart(
              data: [
                PieCategoryData(label: 'Fresh', value: 75, color: Colors.blue),
                PieCategoryData(label: 'Frozen', value: 25, color: Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
