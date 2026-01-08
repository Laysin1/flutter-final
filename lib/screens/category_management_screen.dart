import 'package:flutter/material.dart';

class CategoryManagementScreen extends StatelessWidget {
  final List<String> categories;
  final void Function(String) onEdit;
  final void Function(String) onDelete;
  final VoidCallback onAdd;
  const CategoryManagementScreen({
    super.key,
    required this.categories,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Categories')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        Icons.category,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        cat,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => onEdit(cat),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => onDelete(cat),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
