// views/expense_tracking/expense_categories.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class ExpenseCategoriesScreen extends StatefulWidget {
  const ExpenseCategoriesScreen({super.key});

  @override
  State<ExpenseCategoriesScreen> createState() => _ExpenseCategoriesScreenState();
}

class _ExpenseCategoriesScreenState extends State<ExpenseCategoriesScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Fuel',
      'budget': 5000.0,
      'spent': 3200.0,
      'color': Colors.orange,
      'icon': Icons.local_gas_station,
    },
    {
      'name': 'Salary',
      'budget': 20000.0,
      'spent': 18500.0,
      'color': Colors.green,
      'icon': Icons.people,
    },
    {
      'name': 'Rent & Utilities',
      'budget': 8000.0,
      'spent': 8000.0,
      'color': Colors.blue,
      'icon': Icons.home,
    },
    {
      'name': 'Packaging',
      'budget': 3000.0,
      'spent': 1500.0,
      'color': Colors.purple,
      'icon': Icons.inventory,
    },
    {
      'name': 'Maintenance',
      'budget': 2000.0,
      'spent': 800.0,
      'color': Colors.red,
      'icon': Icons.build,
    },
    {
      'name': 'Marketing',
      'budget': 1500.0,
      'spent': 1200.0,
      'color': Colors.teal,
      'icon': Icons.campaign,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Categories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _buildCategoryCard(category, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog();
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, int index) {
    final spent = category['spent'] as double;
    final budget = category['budget'] as double;
    final percentage = spent / budget;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (category['color'] as Color).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(category['icon'] as IconData, color: category['color']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category['name'] as String,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${spent.toStringAsFixed(0)} / ${budget.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    percentage > 1 ? Colors.red : AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showEditCategoryDialog(category, index);
            },
            icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Category',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Budget',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add category logic
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(Map<String, dynamic> category, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Category',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: category['name']),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Budget',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                text: (category['budget'] as double).toStringAsFixed(0),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update category logic
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}