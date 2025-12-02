import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseHome(),
    );
  }
}

class ExpenseHome extends StatefulWidget {
  @override
  _ExpenseHomeState createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  List expenses = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("expenses");
    if (data != null) {
      setState(() => expenses = jsonDecode(data));
    }
  }

  Future<void> saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("expenses", jsonEncode(expenses));
  }

  void addExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    setState(() {
      expenses.add({
        "title": titleController.text,
        "amount": double.parse(amountController.text),
        "date": DateTime.now().toString()
      });
    });

    saveExpenses();

    titleController.clear();
    amountController.clear();
  }

  void deleteExpense(int index) {
    setState(() => expenses.removeAt(index));
    saveExpenses();
  }

  double getTotal() {
    double total = 0;
    for (var item in expenses) {
      total += item["amount"];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Total
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Total: \$${getTotal().toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Add form
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Expense Title"),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Amount"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addExpense,
                  child: Text("Add Expense"),
                )
              ],
            ),
          ),

          SizedBox(height: 20),

          // List
          Expanded(
            child: expenses.isEmpty
                ? Center(child: Text("No expenses yet"))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: ListTile(
                          title: Text(expenses[index]["title"]),
                          subtitle: Text(expenses[index]["date"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${expenses[index]["amount"]}"),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteExpense(index),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
