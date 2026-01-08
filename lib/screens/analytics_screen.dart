import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  final List expenses;
  const AnalyticsScreen({super.key, required this.expenses});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAnalyticsTab('Daily'),
          _buildAnalyticsTab('Weekly'),
          _buildAnalyticsTab('Monthly'),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab(String period) {
    // Group expenses by category for pie chart
    final Map<String, double> categoryTotals = {};
    for (var exp in widget.expenses) {
      final cat = exp.category;
      categoryTotals[cat] = (categoryTotals[cat] ?? 0) + exp.amount;
    }
    final pieSections = categoryTotals.entries
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            title: e.key,
            color:
                Colors.primaries[categoryTotals.keys.toList().indexOf(e.key) %
                    Colors.primaries.length],
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
        .toList();

    // Group expenses by day for bar chart (last 7 days)
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));
    final dayTotals = List.generate(7, (i) => 0.0);
    for (var exp in widget.expenses) {
      for (int i = 0; i < 7; i++) {
        if (exp.date.year == days[i].year &&
            exp.date.month == days[i].month &&
            exp.date.day == days[i].day) {
          dayTotals[i] += exp.amount;
        }
      }
    }
    final barGroups = List.generate(
      7,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: dayTotals[i],
            color: Colors.blueAccent,
            width: 16,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$period Analytics',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 220,
                  child: PieChart(PieChartData(sections: pieSections)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      barGroups: barGroups,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= days.length)
                                return Container();
                              return Text(
                                '${days[idx].month}/${days[idx].day}',
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
