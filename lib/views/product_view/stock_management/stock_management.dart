// lib/views/stock/stock_management_screen.dart
import 'package:flutter/material.dart';
import '../../../res/colors.dart';
import 'low_stock.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedSort = 'Stock: Low to High';

  final List<String> _filters = ['All', 'Low Stock', 'Out of Stock', 'Healthy Stock'];
  final List<String> _sortOptions = ['Name A-Z', 'Name Z-A', 'Stock: Low to High', 'Stock: High to Low', 'Category'];

  // Sample products data from your catalog
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Mineral Water 1L',
      'category': 'Beverages',
      'price': 5.00,
      'stock': 50,
      'minStock': 20,
      'unit': 'bottle',
      'supplier': 'Aqua Pure Ltd.',
      'status': 'active',
      'lastRestocked': '2024-01-15',
    },
    {
      'id': '2',
      'name': '5 Gallon Water Jug',
      'category': 'Containers',
      'price': 15.00,
      'stock': 30,
      'minStock': 15,
      'unit': 'jug',
      'supplier': 'Container Corp',
      'status': 'active',
      'lastRestocked': '2024-01-10',
    },
    {
      'id': '3',
      'name': 'Water Dispenser',
      'category': 'Equipment',
      'price': 80.00,
      'stock': 15,
      'minStock': 10,
      'unit': 'unit',
      'supplier': 'Dispenser Tech',
      'status': 'active',
      'lastRestocked': '2024-01-05',
    },
    {
      'id': '5',
      'name': 'Water Filter System',
      'category': 'Filters',
      'price': 45.00,
      'stock': 20,
      'minStock': 5,
      'unit': 'system',
      'supplier': 'Filter Masters',
      'status': 'active',
      'lastRestocked': '2024-01-12',
    },
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
    },
    {
      'id': '7',
      'name': 'Bottle Cap',
      'category': 'Accessories',
      'price': 0.50,
      'stock': 200,
      'minStock': 50,
      'unit': 'piece',
      'supplier': 'Plastic Parts Inc.',
      'status': 'active',
      'lastRestocked': '2024-01-18',
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
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = _products;

    // Apply stock status filter
    if (_selectedFilter != 'All') {
      filtered = filtered.where((product) {
        switch (_selectedFilter) {
          case 'Low Stock':
            return product['stock'] > 0 && product['stock'] <= product['minStock'];
          case 'Out of Stock':
            return product['stock'] == 0;
          case 'Healthy Stock':
            return product['stock'] > product['minStock'];
          default:
            return true;
        }
      }).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final query = _searchQuery.toLowerCase();
        return product['name'].toLowerCase().contains(query) ||
            product['category'].toLowerCase().contains(query) ||
            product['supplier'].toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Name A-Z':
          return a['name'].compareTo(b['name']);
        case 'Name Z-A':
          return b['name'].compareTo(a['name']);
        case 'Stock: Low to High':
          return a['stock'].compareTo(b['stock']);
        case 'Stock: High to Low':
          return b['stock'].compareTo(a['stock']);
        case 'Category':
          return a['category'].compareTo(b['category']);
        default:
          return 0;
      }
    });

    return filtered;
  }

  int get _totalProducts => _products.length;
  int get _lowStockCount => _products.where((p) => p['stock'] > 0 && p['stock'] <= p['minStock']).length;
  int get _outOfStockCount => _products.where((p) => p['stock'] == 0).length;
  int get _healthyStockCount => _products.where((p) => p['stock'] > p['minStock']).length;

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _updateStock(String productId, int newStock) {
    setState(() {
      final productIndex = _products.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _products[productIndex]['stock'] = newStock;
        _products[productIndex]['lastRestocked'] = DateTime.now().toIso8601String().split('T')[0];
      }
    });
  }

  // void _bulkRestock(List<String> productIds) {
  //   for (final productId in productIds) {
  //     final productIndex = _products.indexWhere((p) => p['id'] == productId);
  //     if (productIndex != -1) {
  //       final minStock = _products[productIndex]['minStock'];
  //       final suggestedStock = minStock * 2; // Restock to 2x min stock
  //       _products[productIndex]['stock'] = suggestedStock;
  //       _products[productIndex]['lastRestocked'] = DateTime.now().toIso8601String().split('T')[0];
  //     }
  //   }

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Restocked ${productIds.length} products'),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  // }

  void _showUpdateStockDialog(Map<String, dynamic> product) {
    final stockController = TextEditingController(text: product['stock'].toString());
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Stock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${product['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Current Stock: ${product['stock']} ${product['unit']}'),
            Text('Min Stock: ${product['minStock']} ${product['unit']}'),
            const SizedBox(height: 16),
            TextFormField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'New Stock Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (Optional)',
                hintText: 'e.g., New shipment, Adjustment',
                border: OutlineInputBorder(),
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
              final newStock = int.tryParse(stockController.text) ?? product['stock'];
              _updateStock(product['id'], newStock);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Stock updated to $newStock ${product['unit']}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Update Stock'),
          ),
        ],
      ),
    );
  }

  void _showStockHistory(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildStockHistorySheet(product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Stock Management',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LowStockAlertScreen()),
              );
            },
            tooltip: 'Low Stock Alerts',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          _buildSearchFilters(),

          // Stock Overview
          _buildStockOverview(),

          // Products List
          Expanded(
            child: _buildProductsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: _performSearch,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),

          // Filters Row
          Row(
            children: [
              // Stock Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightSkyBlue),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _filters.map((String filter) {
                      return DropdownMenuItem<String>(
                        value: filter,
                        child: Text(
                          filter,
                          style: const TextStyle(
                            color: AppColors.DarkBlue,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Sort Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightSkyBlue),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedSort,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _sortOptions.map((String sort) {
                      return DropdownMenuItem<String>(
                        value: sort,
                        child: Text(
                          sort,
                          style: const TextStyle(
                            color: AppColors.DarkBlue,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSort = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          _buildStockStatItem('Total', _totalProducts.toString(), Icons.inventory, AppColors.primaryBlue),
          const SizedBox(width: 12),
          _buildStockStatItem('Healthy', _healthyStockCount.toString(), Icons.check_circle, Colors.green),
          const SizedBox(width: 12),
          _buildStockStatItem('Low Stock', _lowStockCount.toString(), Icons.warning, Colors.orange),
          const SizedBox(width: 12),
          _buildStockStatItem('Out of Stock', _outOfStockCount.toString(), Icons.error, Colors.red),
        ],
      ),
    );
  }

  Widget _buildStockStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    if (_filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isNotEmpty ? Icons.search_off : Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No products found for "$_searchQuery"'
                  : 'No products match the current filter',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildStockItem(product);
      },
    );
  }

  Widget _buildStockItem(Map<String, dynamic> product) {
    final isOutOfStock = product['stock'] == 0;
    final isLowStock = product['stock'] > 0 && product['stock'] <= product['minStock'];
    final stockPercentage = product['minStock'] > 0 ? (product['stock'] / product['minStock']) : 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getProductIcon(product['category']),
                color: AppColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Product Info
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
                  const SizedBox(height: 4),
                  Text(
                    product['category'],
                    style: const TextStyle(
                      color: AppColors.skyBlue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Stock Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stock: ${product['stock']} ${product['unit']}',
                            style: TextStyle(
                              color: isOutOfStock
                                  ? Colors.red
                                  : isLowStock
                                  ? Colors.orange
                                  : Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Min: ${product['minStock']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: stockPercentage > 1 ? 1 : stockPercentage,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isOutOfStock
                              ? Colors.red
                              : isLowStock
                              ? Colors.orange
                              : Colors.green,
                        ),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _showUpdateStockDialog(product),
                  tooltip: 'Update Stock',
                ),
                IconButton(
                  icon: const Icon(Icons.history, size: 20),
                  onPressed: () => _showStockHistory(product),
                  tooltip: 'Stock History',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockHistorySheet(Map<String, dynamic> product) {
    // Mock stock history data
    final stockHistory = [
      {'date': '2024-01-18', 'change': 50, 'type': 'restock', 'reason': 'New shipment'},
      {'date': '2024-01-15', 'change': -5, 'type': 'sale', 'reason': 'Customer order'},
      {'date': '2024-01-12', 'change': -3, 'type': 'sale', 'reason': 'Customer order'},
      {'date': '2024-01-10', 'change': 100, 'type': 'restock', 'reason': 'Initial stock'},
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Stock History - ${product['name']}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.DarkBlue,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: stockHistory.length,
              itemBuilder: (context, index) {
                final history = stockHistory[index];
                final isRestock = history['type'] == 'restock';

                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isRestock ? Colors.green.shade50 : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isRestock ? Icons.add : Icons.remove,
                      color: isRestock ? Colors.green : Colors.blue,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    isRestock ? 'Restocked' : 'Sold',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(history['reason'].toString()),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isRestock ? '+' : '-'}${history['change']} ${product['unit']}',
                        style: TextStyle(
                          color: isRestock ? Colors.green : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        history['date'].toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
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