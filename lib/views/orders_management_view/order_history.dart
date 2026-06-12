// lib/views/orders/order_history_table_screen.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Delivered', 'Cancelled', 'Returned'];

  // Search
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#1238',
      'customerName': 'James Wilson',
      'customerPhone': '+1 234 567 8906',
      'products': 'Mineral Water 1L x 3, 5 Gallon x 1',
      'totalAmount': 30.00,
      'status': 'delivered',
      'orderDate': '2024-01-10',
      'paymentMethod': 'Credit Card',
      'deliveryAgent': 'Mike Johnson',
    },
    {
      'id': '#1237',
      'customerName': 'Maria Garcia',
      'customerPhone': '+1 234 567 8907',
      'products': 'Water Dispenser x 1, 5 Gallon x 2',
      'totalAmount': 110.00,
      'status': 'delivered',
      'orderDate': '2024-01-09',
      'paymentMethod': 'Cash on Delivery',
      'deliveryAgent': 'Sarah Wilson',
    },
    {
      'id': '#1236',
      'customerName': 'Thomas Brown',
      'customerPhone': '+1 234 567 8908',
      'products': 'Mineral Water 1L x 12',
      'totalAmount': 60.00,
      'status': 'cancelled',
      'orderDate': '2024-01-08',
      'paymentMethod': 'Digital Wallet',
      'deliveryAgent': 'Not Assigned',
    },
    {
      'id': '#1235',
      'customerName': 'Jennifer Lee',
      'customerPhone': '+1 234 567 8909',
      'products': '5 Gallon x 4',
      'totalAmount': 60.00,
      'status': 'delivered',
      'orderDate': '2024-01-07',
      'paymentMethod': 'Credit Card',
      'deliveryAgent': 'David Lee',
    },
    {
      'id': '#1234',
      'customerName': 'Robert Taylor',
      'customerPhone': '+1 234 567 8910',
      'products': 'Water Filter x 1, Mineral Water 1L x 6',
      'totalAmount': 75.00,
      'status': 'returned',
      'orderDate': '2024-01-06',
      'paymentMethod': 'Cash on Delivery',
      'deliveryAgent': 'Mike Johnson',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    List<Map<String, dynamic>> filtered = _orders;

    if (_selectedFilter != 'All') {
      filtered = filtered.where((order) {
        return order['status'] == _selectedFilter.toLowerCase();
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        final query = _searchQuery.toLowerCase();
        return order['id'].toLowerCase().contains(query) ||
            order['customerName'].toLowerCase().contains(query) ||
            order['customerPhone'].contains(query);
      }).toList();
    }

    return filtered;
  }

  void _openSearch() {
    setState(() => _isSearching = true);
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _performSearch(String query) {
    setState(() => _searchQuery = query);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'returned':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      case 'returned':
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  String _getTotalAmount() {
    double total = 0;
    for (var order in _filteredOrders) {
      total += order['totalAmount'];
    }
    return total.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : const Text(
                'Order History',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: _buildAppBarActions(),
      ),
      body: Column(
        children: [
          if (!_isSearching) _buildControlsRow(),
          Expanded(child: _buildDataTable()),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear, color: AppColors.primaryBlue),
          onPressed: _closeSearch,
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.primaryBlue),
          onPressed: _openSearch,
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'Search orders...',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: _clearSearch,
                  color: AppColors.primaryBlue,
                )
              : null,
        ),
        style: const TextStyle(color: AppColors.DarkBlue, fontSize: 16),
      ),
    );
  }

  Widget _buildControlsRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.lightSkyBlue),
            ),
            child: DropdownButton<String>(
              value: _selectedFilter,
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
          const SizedBox(width: 16),
          Text(
            '${_filteredOrders.length} orders found',
            style: const TextStyle(
              color: AppColors.DarkBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            'Total: \$${_getTotalAmount()}',
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    if (_filteredOrders.isEmpty) {
      return const Center(
        child: Text(
          'No orders found',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(
          AppColors.primaryBlue.withValues(alpha: 0.1),
        ),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.DarkBlue,
        ),
        columnSpacing: 20,
        border: TableBorder.all(color: Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Order ID')),
          DataColumn(label: Text('Customer')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Products')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Payment')),
          DataColumn(label: Text('Delivery Agent')),
        ],
        rows: _filteredOrders.map((order) {
          return DataRow(
            cells: [
              DataCell(Text(order['id'])),
              DataCell(Text(order['customerName'])),
              DataCell(Text(order['customerPhone'])),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Text(
                    order['products'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(Text("\$${order['totalAmount']}")),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      order['status'],
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getStatusColor(order['status'])),
                  ),
                  child: Text(
                    _getStatusText(order['status']),
                    style: TextStyle(
                      color: _getStatusColor(order['status']),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataCell(Text(order['orderDate'])),
              DataCell(Text(order['paymentMethod'])),
              DataCell(Text(order['deliveryAgent'])),
            ],
          );
        }).toList(),
      ),
    );
  }
}
