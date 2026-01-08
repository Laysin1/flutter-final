import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;
  final double totalExpenses;
  final List<Map<String, dynamic>> recentExpenses;
  final void Function(String) onEdit;
  final void Function(String) onDelete;
  final VoidCallback onAddExpense;
  final int selectedPeriodIndex;
  final void Function(int) onPeriodChange;
  const DashboardScreen({
    super.key,
    required this.userName,
    required this.totalExpenses,
    required this.recentExpenses,
    required this.onEdit,
    required this.onDelete,
    required this.onAddExpense,
    required this.selectedPeriodIndex,
    required this.onPeriodChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: Color(0xFF7C3AED)),
            onPressed: onAddExpense,
            tooltip: 'Add Expense',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(
                        color: Color(0xFF7C3AED),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalExpenses.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF22223B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Period Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  borderRadius: BorderRadius.circular(16),
                  isSelected: [
                    0,
                    1,
                    2,
                  ].map((i) => i == selectedPeriodIndex).toList(),
                  onPressed: onPeriodChange,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Daily'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Weekly'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Monthly'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Expense Bar Chart
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: SizedBox(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= recentExpenses.length)
                                return Container();
                              final date = recentExpenses[idx]['date'] ?? '';
                              return Text(
                                date,
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
                      barGroups: [
                        for (int i = 0; i < recentExpenses.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY:
                                    (recentExpenses[i]['amount'] as num?)
                                        ?.toDouble() ??
                                    0,
                                color: const Color(0xFF7C3AED),
                                width: 16,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Recent Expenses Table
            const Text(
              'Recent Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: recentExpenses.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exp = recentExpenses[index];
                    return ListTile(
                      leading: Icon(exp['icon'], color: Color(0xFF7C3AED)),
                      title: Text(
                        exp['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(exp['date']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${exp['amount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => onEdit(exp['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => onDelete(exp['id']),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
