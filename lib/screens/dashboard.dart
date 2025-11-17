import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/chatbot_popup.dart';
import '../widgets/bottom_nav.dart';
import 'upload.dart';
import 'history.dart';
import 'profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UploadScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HistoryScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo carbon.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              "CarbonScan",
              style: TextStyle(
                color: Color(0xFF2D6A4F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Emisi',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 20),

            const _InfoCard(
              title: 'Total Emisi Bulan Ini',
              value: '12.450 kg',
              color: Colors.blue,
            ),
            const SizedBox(height: 16),

            const _ChartCard(
              title: 'Tren Emisi Bulanan',
              child: _LineChartExample(),
            ),
            const SizedBox(height: 16),

            const _ChartCard(
              title: 'Emisi per Kategori Bahan',
              child: _PieChartExample(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ChatbotPopup(),
          );
        },
        backgroundColor: const Color(0xFF2D6A4F),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    );
  }
}

// Info card
class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Chart card
class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Line chart
class _LineChartExample extends StatelessWidget {
  const _LineChartExample();

  @override
  Widget build(BuildContext context) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov'
    ];

    final spots = [
      FlSpot(0, 13.0),
      FlSpot(1, 13.4),
      FlSpot(2, 12.8),
      FlSpot(3, 13.6),
      FlSpot(4, 13.2),
      FlSpot(5, 12.9),
      FlSpot(6, 13.7),
      FlSpot(7, 13.3),
      FlSpot(8, 13.1),
      FlSpot(9, 12.7),
      FlSpot(10, 12.5),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      months[value.toInt()],
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 10,
        minY: 12.0,
        maxY: 14.0,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.green[800],
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

// Pie chart
class _PieChartExample extends StatelessWidget {
  const _PieChartExample();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: Colors.redAccent,
            value: 45,
            title: 'Daging & Produk\nHewani\n45%',
            radius: 65,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          PieChartSectionData(
            color: Colors.orangeAccent,
            value: 30,
            title: 'Bahan Pokok\n30%',
            radius: 65,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          PieChartSectionData(
            color: Colors.green,
            value: 25,
            title: 'Sayuran & Buah\n25%',
            radius: 65,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
