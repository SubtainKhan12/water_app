// lib/views/stock/low_stock_alert_screen.dart
import 'package:flutter/material.dart';
import '../../../res/colors.dart';

class LowStockAlertScreen extends StatefulWidget {
  const LowStockAlertScreen({super.key});

  @override
  State<LowStockAlertScreen> createState() => _LowStockAlertScreenState();
}

class _LowStockAlertScreenState extends State<LowStockAlertScreen> {
  final List<Map<String, dynamic>> _lowStockProducts = [
    {
      'id': '6',
      'name': 'Water Filter Cartridge',
      'category': 'Filters',
      'price': 8.00,
      'stock': 5,
      'minStock': 10,
      'unit': 'cartridge',
      'supplier': 'Filter Masters',
      'status': 'active',
      'lastRestocked': '2024-01-08',
      'urgency': 'high', // high, medium, low
      'daysOutOfStock': 2,
    },
    {
      'id': '8',
      'name': 'Mineral Water 500ml',
      'category': 'Beverages',
      'price': 3.00,
      'stock': 0,
      'minStock': 25,
      'unit': 'bottle',
      'supplier': 'Aqua Pure Ltd.',
      'status': 'inactive',
      'lastRestocked': '2024-01-03',
      'urgency': 'high',
      'daysOutOfStock': 5,
    },
    {
      'id': '7',
      'name': 'Bottle Cap',
      'category': 'Accessories',
      'price': 0.50,
      'stock': 45,
      'minStock': 50,
      'unit': 'piece',
      'supplier': 'Plastic Parts Inc.',
      'status': 'active',
      'lastRestocked': '2024-01-18',
      'urgency': 'medium',
      'daysOutOfStock': 0,
    },
    {
      'id': '2',
      'name': '5 Gallon Water Jug',
      'category': 'Containers',
      'price': 15.00,
      'stock': 18,
      'minStock': 15,
      'unit': 'jug',
      'supplier': 'Container Corp',
      'status': 'active',
      'lastRestocked': '2024-01-10',
      'urgency': 'low',
      'daysOutOfStock': 0,
    },
  ];

  String _selectedUrgency = 'All';
  final List<String> _urgencyFilters = ['All', 'High', 'Medium', 'Low'];

  List<Map<String, dynamic>> get _filteredAlerts {
    if (_selectedUrgency == 'All') return _lowStockProducts;

    return _lowStockProducts.where((product) {
      return product['urgency'] == _selectedUrgency.toLowerCase();
    }).toList();
  }

  int get _highUrgencyCount =>
      _lowStockProducts.where((p) => p['urgency'] == 'high').length;
  int get _mediumUrgencyCount =>
      _lowStockProducts.where((p) => p['urgency'] == 'medium').length;
  int get _lowUrgencyCount =>
      _lowStockProducts.where((p) => p['urgency'] == 'low').length;

  void _restockProduct(String productId, int quantity) {
    setState(() {
      final productIndex = _lowStockProducts.indexWhere(
        (p) => p['id'] == productId,
      );
      if (productIndex != -1) {
        _lowStockProducts[productIndex]['stock'] = quantity;
        _lowStockProducts[productIndex]['lastRestocked'] = DateTime.now()
            .toIso8601String()
            .split('T')[0];
        _lowStockProducts[productIndex]['urgency'] = 'low';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Product restocked successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _contactSupplier(String supplier, String productName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Supplier'),
        content: Text(
          'Would you like to contact $supplier regarding $productName?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement contact logic (email, phone, etc.)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contacting $supplier...'),
                  backgroundColor: AppColors.primaryBlue,
                ),
              );
            },
            child: const Text('Contact'),
          ),
        ],
      ),
    );
  }

  void _quickRestock(Map<String, dynamic> product) {
    final suggestedQuantity = product['minStock'] * 2;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick Restock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${product['name']}'),
            Text('Current Stock: ${product['stock']} ${product['unit']}'),
            Text('Minimum Stock: ${product['minStock']} ${product['unit']}'),
            const SizedBox(height: 16),
            const Text('Suggested restock quantity:'),
            Text(
              '$suggestedQuantity ${product['unit']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
                fontSize: 18,
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
              _restockProduct(product['id'], suggestedQuantity);
              Navigator.pop(context);
            },
            child: const Text('Restock'),
          ),
        ],
      ),
    );
  }

  void _bulkRestockAll() {
    for (final product in _lowStockProducts) {
      final suggestedQuantity = product['minStock'] * 2;
      _restockProduct(product['id'], suggestedQuantity);
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getUrgencyText(String urgency) {
    switch (urgency) {
      case 'high':
        return 'High Priority';
      case 'medium':
        return 'Medium Priority';
      case 'low':
        return 'Low Priority';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Low Stock Alerts',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_lowStockProducts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.inventory_2, color: AppColors.primaryBlue),
              onPressed: _bulkRestockAll,
              tooltip: 'Restock All',
            ),
        ],
      ),
      body: Column(
        children: [
          // Alert Summary
          _buildAlertSummary(),

          // Urgency Filter
          _buildUrgencyFilter(),

          // Alerts List
          Expanded(child: _buildAlertsList()),
        ],
      ),
    );
  }

  Widget _buildAlertSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.shade50,
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stock Alerts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${_lowStockProducts.length} products need attention',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
          ),
          if (_highUrgencyCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_highUrgencyCount Critical',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUrgencyFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: _urgencyFilters.map((urgency) {
          final isSelected = _selectedUrgency == urgency;
          final count = urgency == 'All'
              ? _lowStockProducts.length
              : urgency == 'High'
              ? _highUrgencyCount
              : urgency == 'Medium'
              ? _mediumUrgencyCount
              : _lowUrgencyCount;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedUrgency = urgency;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? _getUrgencyColor(urgency.toLowerCase())
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? _getUrgencyColor(urgency.toLowerCase())
                        : Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      count.toString(),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : _getUrgencyColor(urgency.toLowerCase()),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      urgency,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAlertsList() {
    if (_filteredAlerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green.shade300,
            ),
            const SizedBox(height: 16),
            const Text(
              'No stock alerts!',
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'All products are well stocked',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredAlerts.length,
      itemBuilder: (context, index) {
        final product = _filteredAlerts[index];
        return _buildAlertItem(product);
      },
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> product) {
    final isOutOfStock = product['stock'] == 0;
    final urgencyColor = _getUrgencyColor(product['urgency']);
    final stockDeficit = product['minStock'] - product['stock'];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: urgencyColor, width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with urgency
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: urgencyColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getUrgencyText(product['urgency']),
                      style: TextStyle(
                        color: urgencyColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isOutOfStock)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'OUT OF STOCK',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Product Info
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getProductIcon(product['category']),
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.DarkBlue,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          product['category'],
                          style: const TextStyle(
                            color: AppColors.skyBlue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Stock Information
              Row(
                children: [
                  _buildStockInfo(
                    'Current Stock',
                    '${product['stock']} ${product['unit']}',
                    urgencyColor,
                  ),
                  _buildStockInfo(
                    'Minimum Required',
                    '${product['minStock']} ${product['unit']}',
                    Colors.grey,
                  ),
                  _buildStockInfo(
                    'Deficit',
                    '$stockDeficit ${product['unit']}',
                    Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Supplier Info
              Text(
                'Supplier: ${product['supplier']}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 12),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _contactSupplier(
                        product['supplier'],
                        product['name'],
                      ),
                      icon: const Icon(Icons.contact_phone, size: 16),
                      label: const Text('Contact Supplier'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _quickRestock(product),
                      icon: const Icon(Icons.inventory, size: 16),
                      label: const Text('Quick Restock'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockInfo(String label, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getProductIcon(String category) {
    switch (category) {
      case 'Beverages':
        return Icons.local_drink;
      case 'Containers':
        return Icons.water_drop;
      case 'Equipment':
        return Icons.kitchen;
      case 'Filters':
        return Icons.filter_alt;
      case 'Accessories':
        return Icons.construction;
      default:
        return Icons.inventory_2;
    }
  }
}
