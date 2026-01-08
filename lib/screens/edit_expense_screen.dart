import 'package:flutter/material.dart';

class EditExpenseScreen extends StatelessWidget {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;
  final List<String> categories;
  final void Function(String, double, String, DateTime, String?) onSave;
  const EditExpenseScreen({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
    required this.categories,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final titleCtrl = TextEditingController(text: title);
    final amountCtrl = TextEditingController(text: amount.toString());
    final notesCtrl = TextEditingController(text: notes ?? '');
    String selectedCategory = category;
    DateTime selectedDate = date;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Expense')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Expense',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Expense Title',
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category),
                ),
                items: categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) selectedCategory = val;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Date: \\${selectedDate.toLocal().toString().split(' ')[0]}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) selectedDate = picked;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    onSave(
                      titleCtrl.text,
                      double.tryParse(amountCtrl.text) ?? amount,
                      selectedCategory,
                      selectedDate,
                      notesCtrl.text.isNotEmpty ? notesCtrl.text : null,
                    );
                  },
                  child: const Text('Update Expense'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
