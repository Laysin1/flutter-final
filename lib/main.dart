import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: ExpenseHome(),
    );
  }
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
    'notes': notes,
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json['id'],
    title: json['title'],
    amount: (json['amount'] as num).toDouble(),
    category: json['category'],
    date: DateTime.parse(json['date']),
    notes: json['notes'],
  );
}

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  List<Expense> expenses = [];
  int _selectedIndex = 0;

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Utilities',
    'Shopping',
    'Health',
    'Education',
    'Other',
  ];

  final Map<String, Color> categoryColors = {
    'Food': Colors.orange,
    'Transport': Colors.blue,
    'Entertainment': Colors.purple,
    'Utilities': Colors.green,
    'Shopping': Colors.pink,
    'Health': Colors.red,
    'Education': Colors.indigo,
    'Other': Colors.grey,
  };

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  String? selectedCategory;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("expenses");
    if (data != null) {
      List jsonData = jsonDecode(data);
      setState(() {
        expenses = jsonData.map((e) => Expense.fromJson(e)).toList();
        expenses.sort((a, b) => b.date.compareTo(a.date));
      });
    }
  }

  Future<void> saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonData = expenses.map((e) => e.toJson()).toList();
    prefs.setString("expenses", jsonEncode(jsonData));
  }

  void addExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    try {
      Expense newExpense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        amount: double.parse(amountController.text),
        category: selectedCategory!,
        date: selectedDate,
        notes: notesController.text.isNotEmpty ? notesController.text : null,
      );

      setState(() {
        expenses.add(newExpense);
        expenses.sort((a, b) => b.date.compareTo(a.date));
      });

      saveExpenses();
      clearForm();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Expense added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding expense')));
    }
  }

  void clearForm() {
    titleController.clear();
    amountController.clear();
    notesController.clear();
    selectedDate = DateTime.now();
    selectedCategory = categories[0];
  }

  void deleteExpense(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Expense?'),
        content: Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => expenses.removeWhere((e) => e.id == id));
              saveExpenses();
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Expense deleted')));
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  double getTotalExpenses() {
    return expenses.fold(0, (sum, e) => sum + e.amount);
  }

  double getTotalByCategory(String category) {
    return expenses
        .where((e) => e.category == category)
        .fold(0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        elevation: 0,
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? _buildHomeTab()
          : _selectedIndex == 1
          ? _buildChartsTab()
          : _selectedIndex == 2
          ? _buildAddExpenseTab()
          : _buildHistoryTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Charts'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Total Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Total Expenses',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${getTotalExpenses().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Category Summary
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ...categories.map((category) {
                  double amount = getTotalByCategory(category);
                  return amount > 0
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: _buildCategoryItem(category, amount),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Recent Expenses
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Expenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ...expenses.take(5).map((expense) {
                  return _buildExpenseCard(expense);
                }),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount) {
    double percentage = getTotalExpenses() == 0
        ? 0
        : (amount / getTotalExpenses()) * 100;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: categoryColors[category],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(category, style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(categoryColors[category]!),
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsTab() {
    if (expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No expense data available', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),

          // Pie Chart
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense Distribution',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                SizedBox(height: 300, child: _buildPieChart()),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Bar Chart
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spending by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                SizedBox(height: 300, child: _buildBarChart()),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Statistics
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                _buildStatisticsGrid(),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    List<PieChartSectionData> sections = [];

    for (String category in categories) {
      double amount = getTotalByCategory(category);
      if (amount > 0) {
        sections.add(
          PieChartSectionData(
            value: amount,
            title: category,
            color: categoryColors[category],
            radius: 100,
          ),
        );
      }
    }

    return PieChart(PieChartData(sections: sections));
  }

  Widget _buildBarChart() {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < categories.length; i++) {
      double amount = getTotalByCategory(categories[i]);
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: amount,
              color: categoryColors[categories[i]],
              width: 16,
            ),
          ],
        ),
      );
    }

    double maxY = expenses.isEmpty
        ? 100
        : expenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b) * 1.2;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barGroups: barGroups,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < categories.length) {
                  return Text(
                    categories[index],
                    style: TextStyle(fontSize: 10),
                  );
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('\$${value.toInt()}');
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    double avgExpense = expenses.isEmpty
        ? 0
        : getTotalExpenses() / expenses.length;
    double maxExpense = expenses.isEmpty
        ? 0
        : expenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    String topCategory = categories.isEmpty
        ? 'N/A'
        : categories.reduce(
            (a, b) => getTotalByCategory(a) > getTotalByCategory(b) ? a : b,
          );

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          'Total Transactions',
          expenses.length.toString(),
          Colors.blue,
        ),
        _buildStatCard(
          'Average Expense',
          '\$${avgExpense.toStringAsFixed(2)}',
          Colors.green,
        ),
        _buildStatCard(
          'Highest Expense',
          '\$${maxExpense.toStringAsFixed(2)}',
          Colors.orange,
        ),
        _buildStatCard('Top Category', topCategory, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddExpenseTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Expense',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),

            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Expense Title',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Category
            DropdownButtonFormField<String>(
              initialValue: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) => setState(() => selectedCategory = value),
            ),
            SizedBox(height: 16),

            // Date Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Date: ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => selectedDate = picked);
              },
            ),
            SizedBox(height: 16),

            // Notes
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Add Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add Expense',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return expenses.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No expenses yet', style: TextStyle(fontSize: 16)),
              ],
            ),
          )
        : ListView.builder(
            itemCount: expenses.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) => _buildExpenseCard(expenses[index]),
          );
  }

  Widget _buildExpenseCard(Expense expense) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: categoryColors[expense.category]!.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getCategoryIcon(expense.category),
            color: categoryColors[expense.category],
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              expense.category,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              DateFormat('MMM dd, yyyy').format(expense.date),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            if (expense.notes != null && expense.notes!.isNotEmpty)
              Text(
                expense.notes!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'delete') deleteExpense(expense.id);
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
          child: Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Transport':
        return Icons.directions_car;
      case 'Entertainment':
        return Icons.movie;
      case 'Utilities':
        return Icons.lightbulb;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Health':
        return Icons.health_and_safety;
      case 'Education':
        return Icons.school;
      default:
        return Icons.category;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
