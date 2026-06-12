import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/widgets/round_button.dart';
import 'create_new_order.dart';

class ViewAllOrdersScreen extends StatefulWidget {
  const ViewAllOrdersScreen({super.key});

  @override
  State<ViewAllOrdersScreen> createState() => _ViewAllOrdersScreenState();
}

class _ViewAllOrdersScreenState extends State<ViewAllOrdersScreen> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Newest First';
  final List<String> _filters = [
    'All',
    'Pending',
    'Confirmed',
    'Out for Delivery',
    'Delivered',
    'Cancelled',
  ];
  final List<String> _sortOptions = [
    'Newest First',
    'Oldest First',
    'Price: High to Low',
    'Price: Low to High',
  ];

  // Search functionality
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample orders data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#1247',
      'customerName': 'John Doe',
      'customerPhone': '+1 234 567 8900',
      'products': 'Mineral Water 1L x 5, 5 Gallon x 2',
      'totalAmount': 45.50,
      'status': 'pending',
      'orderDate': '2024-01-15 14:30',
      'deliveryDate': '2024-01-16',
      'address': '123 Main St, City, State 12345',
      'paymentMethod': 'Credit Card',
      'deliveryAgent': 'Not Assigned',
    },
    {
      'id': '#1246',
      'customerName': 'Sarah Smith',
      'customerPhone': '+1 234 567 8901',
      'products': '5 Gallon x 4, Dispenser x 1',
      'totalAmount': 120.00,
      'status': 'confirmed',
      'orderDate': '2024-01-15 12:15',
      'deliveryDate': '2024-01-15',
      'address': '456 Oak Ave, City, State 12345',
      'paymentMethod': 'Cash on Delivery',
      'deliveryAgent': 'Mike Johnson',
    },
    {
      'id': '#1245',
      'customerName': 'Robert Brown',
      'customerPhone': '+1 234 567 8902',
      'products': 'Mineral Water 1L x 10',
      'totalAmount': 25.00,
      'status': 'out_for_delivery',
      'orderDate': '2024-01-15 10:45',
      'deliveryDate': '2024-01-15',
      'address': '789 Pine Rd, City, State 12345',
      'paymentMethod': 'Credit Card',
      'deliveryAgent': 'Sarah Wilson',
    },
    {
      'id': '#1244',
      'customerName': 'Emily Davis',
      'customerPhone': '+1 234 567 8903',
      'products': '5 Gallon x 1',
      'totalAmount': 15.00,
      'status': 'delivered',
      'orderDate': '2024-01-14 16:20',
      'deliveryDate': '2024-01-15',
      'address': '321 Elm St, City, State 12345',
      'paymentMethod': 'Digital Wallet',
      'deliveryAgent': 'Mike Johnson',
    },
    {
      'id': '#1243',
      'customerName': 'Michael Wilson',
      'customerPhone': '+1 234 567 8904',
      'products': 'Mineral Water 1L x 8, 5 Gallon x 3',
      'totalAmount': 85.00,
      'status': 'cancelled',
      'orderDate': '2024-01-14 14:10',
      'deliveryDate': '2024-01-15',
      'address': '654 Maple Dr, City, State 12345',
      'paymentMethod': 'Credit Card',
      'deliveryAgent': 'Not Assigned',
    },
    {
      'id': '#1242',
      'customerName': 'Lisa Anderson',
      'customerPhone': '+1 234 567 8905',
      'products': 'Dispenser x 1, 5 Gallon x 2',
      'totalAmount': 95.00,
      'status': 'delivered',
      'orderDate': '2024-01-14 11:30',
      'deliveryDate': '2024-01-14',
      'address': '987 Cedar Ln, City, State 12345',
      'paymentMethod': 'Cash on Delivery',
      'deliveryAgent': 'David Lee',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    List<Map<String, dynamic>> filtered = _orders;

    // Apply status filter
    if (_selectedFilter != 'All') {
      filtered = filtered.where((order) {
        switch (_selectedFilter) {
          case 'Pending':
            return order['status'] == 'pending';
          case 'Confirmed':
            return order['status'] == 'confirmed';
          case 'Out for Delivery':
            return order['status'] == 'out_for_delivery';
          case 'Delivered':
            return order['status'] == 'delivered';
          case 'Cancelled':
            return order['status'] == 'cancelled';
          default:
            return true;
        }
      }).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        final query = _searchQuery.toLowerCase();
        return order['id'].toLowerCase().contains(query) ||
            order['customerName'].toLowerCase().contains(query) ||
            order['customerPhone'].contains(query) ||
            order['products'].toLowerCase().contains(query) ||
            order['address'].toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Newest First':
          return b['orderDate'].compareTo(a['orderDate']);
        case 'Oldest First':
          return a['orderDate'].compareTo(b['orderDate']);
        case 'Price: High to Low':
          return b['totalAmount'].compareTo(a['totalAmount']);
        case 'Price: Low to High':
          return a['totalAmount'].compareTo(b['totalAmount']);
        default:
          return 0;
      }
    });

    return filtered;
  }

  void _openSearch() {
    setState(() {
      _isSearching = true;
    });
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
    setState(() {
      _searchQuery = query;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'out_for_delivery':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pending Confirmation';
      case 'confirmed':
        return 'Confirmed';
      case 'out_for_delivery':
        return 'Out for Delivery';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending_actions;
      case 'confirmed':
        return Icons.check_circle;
      case 'out_for_delivery':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.verified;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildOrderDetailsSheet(order),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) {
    setState(() {
      final orderIndex = _orders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        _orders[orderIndex]['status'] = newStatus;
      }
    });
    Navigator.pop(context);
  }

  void _showStatusUpdateDialog(String orderId, String currentStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Order Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusOption(
              orderId,
              'pending',
              'Pending Confirmation',
              currentStatus,
            ),
            _buildStatusOption(
              orderId,
              'confirmed',
              'Confirmed',
              currentStatus,
            ),
            _buildStatusOption(
              orderId,
              'out_for_delivery',
              'Out for Delivery',
              currentStatus,
            ),
            _buildStatusOption(
              orderId,
              'delivered',
              'Delivered',
              currentStatus,
            ),
            _buildStatusOption(
              orderId,
              'cancelled',
              'Cancelled',
              currentStatus,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(
    String orderId,
    String status,
    String text,
    String currentStatus,
  ) {
    return ListTile(
      leading: Icon(_getStatusIcon(status), color: _getStatusColor(status)),
      title: Text(
        text,
        style: TextStyle(
          color: currentStatus == status
              ? AppColors.primaryBlue
              : AppColors.DarkBlue,
          fontWeight: currentStatus == status
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      trailing: currentStatus == status
          ? const Icon(Icons.check, color: AppColors.primaryBlue)
          : null,
      onTap: () => _updateOrderStatus(orderId, status),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : const Text(
                'All Orders',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: _buildAppBarActions(),
      ),
      body: Column(
        children: [
          // Filter and Sort Row (only show when not searching)
          if (!_isSearching) _buildFilterSortRow(),

          // Orders Count
          _buildOrdersCount(),

          // Orders List
          Expanded(child: _buildOrdersList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new order
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNewOrderScreen()),
          );
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
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
        IconButton(
          icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
          onPressed: () {
            // Show filter options
          },
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

  Widget _buildFilterSortRow() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Filter Dropdown
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
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

          // Sort Dropdown
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
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
    );
  }

  Widget _buildOrdersCount() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredOrders.length} orders found',
            style: const TextStyle(
              color: AppColors.DarkBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_searchQuery.isNotEmpty)
            Text(
              'Search: "$_searchQuery"',
              style: const TextStyle(color: AppColors.skyBlue, fontSize: 12),
            ),
          Text(
            'Total: \$${_getTotalAmount()}',
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getTotalAmount() {
    double total = 0;
    for (var order in _filteredOrders) {
      total += order['totalAmount'];
    }
    return total.toStringAsFixed(2);
  }

  Widget _buildOrdersList() {
    if (_filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isNotEmpty ? Icons.search_off : Icons.inventory_2,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No orders found for "$_searchQuery"'
                  : 'No orders available',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            if (_searchQuery.isNotEmpty)
              TextButton(
                onPressed: _clearSearch,
                child: const Text(
                  'Clear search',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final order = _filteredOrders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showOrderDetails(order),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.DarkBlue,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        order['status'],
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(order['status']),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(order['status']),
                          size: 14,
                          color: _getStatusColor(order['status']),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getStatusText(order['status']),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getStatusColor(order['status']),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Customer Info
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order['customerName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.DarkBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Products
              Row(
                children: [
                  const Icon(
                    Icons.inventory,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order['products'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Order Date
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order['orderDate'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${order['totalAmount']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        onPressed: () => _showStatusUpdateDialog(
                          order['id'],
                          order['status'],
                        ),
                        color: AppColors.primaryBlue,
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility, size: 18),
                        onPressed: () => _showOrderDetails(order),
                        color: AppColors.skyBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailsSheet(Map<String, dynamic> order) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    order['status'],
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _getStatusColor(order['status'])),
                ),
                child: Text(
                  _getStatusText(order['status']),
                  style: TextStyle(
                    color: _getStatusColor(order['status']),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Information
                  _buildDetailSection('Order Information', Icons.receipt, [
                    _buildDetailItem('Order ID', order['id']),
                    _buildDetailItem('Order Date', order['orderDate']),
                    _buildDetailItem('Delivery Date', order['deliveryDate']),
                    _buildDetailItem(
                      'Total Amount',
                      '\$${order['totalAmount']}',
                    ),
                    _buildDetailItem('Payment Method', order['paymentMethod']),
                  ]),

                  const SizedBox(height: 24),

                  // Customer Information
                  _buildDetailSection('Customer Information', Icons.person, [
                    _buildDetailItem('Customer Name', order['customerName']),
                    _buildDetailItem('Phone', order['customerPhone']),
                    _buildDetailItem('Delivery Address', order['address']),
                  ]),

                  const SizedBox(height: 24),

                  // Products
                  _buildDetailSection('Products', Icons.inventory, [
                    _buildDetailItem('Items', order['products']),
                  ]),

                  const SizedBox(height: 24),

                  // Delivery Information
                  _buildDetailSection(
                    'Delivery Information',
                    Icons.local_shipping,
                    [
                      _buildDetailItem(
                        'Delivery Agent',
                        order['deliveryAgent'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  text: 'Update Status',
                  onPressed: () {
                    Navigator.pop(context);
                    _showStatusUpdateDialog(order['id'], order['status']);
                  },
                  backgroundColor: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RoundedButton(
                  text: 'Close',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.grey.shade300,
                  textColor: AppColors.DarkBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.DarkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.DarkBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
