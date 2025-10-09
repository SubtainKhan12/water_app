// lib/views/customers/customer_management_screen.dart
import 'package:flutter/material.dart';
import 'package:water_app/views/customer_management/create_customer.dart';
import '../../res/colors.dart';
import 'customer_detail.dart';


class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample customers data
  final List<Map<String, dynamic>> _customers = [
    {
      'id': '1',
      'name': 'John Doe',
      'phone': '+1 234 567 8900',
      'email': 'john.doe@email.com',
      'address': '123 Main St, City, State 12345',
      'joinDate': '2024-01-15',
      'totalOrders': 12,
      'totalSpent': 450.50,
      'currentBalance': 0.00,
      'lastOrderDate': '2024-01-20',
      'status': 'active',
    },
    {
      'id': '2',
      'name': 'Sarah Smith',
      'phone': '+1 234 567 8901',
      'email': 'sarah.smith@email.com',
      'address': '456 Oak Ave, City, State 12345',
      'joinDate': '2024-01-10',
      'totalOrders': 8,
      'totalSpent': 320.00,
      'currentBalance': 45.00,
      'lastOrderDate': '2024-01-18',
      'status': 'active',
    },
    {
      'id': '3',
      'name': 'Robert Brown',
      'phone': '+1 234 567 8902',
      'email': 'robert.brown@email.com',
      'address': '789 Pine Rd, City, State 12345',
      'joinDate': '2024-01-05',
      'totalOrders': 15,
      'totalSpent': 625.75,
      'currentBalance': -120.50,
      'lastOrderDate': '2024-01-22',
      'status': 'active',
    },
    {
      'id': '4',
      'name': 'Emily Davis',
      'phone': '+1 234 567 8903',
      'email': 'emily.davis@email.com',
      'address': '321 Elm St, City, State 12345',
      'joinDate': '2023-12-20',
      'totalOrders': 25,
      'totalSpent': 980.25,
      'currentBalance': 0.00,
      'lastOrderDate': '2024-01-19',
      'status': 'active',
    },
    {
      'id': '5',
      'name': 'Michael Wilson',
      'phone': '+1 234 567 8904',
      'email': 'michael.wilson@email.com',
      'address': '654 Maple Dr, City, State 12345',
      'joinDate': '2024-01-12',
      'totalOrders': 3,
      'totalSpent': 85.00,
      'currentBalance': 85.00,
      'lastOrderDate': '2024-01-15',
      'status': 'inactive',
    },
  ];

  List<Map<String, dynamic>> get _filteredCustomers {
    if (_searchQuery.isEmpty) return _customers;

    return _customers.where((customer) {
      final query = _searchQuery.toLowerCase();
      return customer['name'].toLowerCase().contains(query) ||
          customer['phone'].contains(query) ||
          customer['email'].toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openAddCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateCustomerScreen(),
      ),
    ).then((value) {
      if (value != null && value == true) {
        // Refresh customer list if new customer was added
        setState(() {});
      }
    });
  }

  void _showCustomerDetails(Map<String, dynamic> customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailsScreen(customer: customer),
      ),
    );
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Customer Management',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryBlue,
          tabs: const [
            Tab(text: 'Customer List'),
            Tab(text: 'Add Customer'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Customer List Tab
          _buildCustomerListTab(),

          // Add Customer Tab
          const CreateCustomerScreen(),
        ],
      ),
    );
  }

  Widget _buildCustomerListTab() {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade50,
          child: TextField(
            controller: _searchController,
            onChanged: _performSearch,
            decoration: InputDecoration(
              hintText: 'Search customers...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        // Customer Count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_filteredCustomers.length} customers found',
                style: const TextStyle(
                  color: AppColors.DarkBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Active: ${_customers.where((c) => c['status'] == 'active').length}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // Customers List
        Expanded(
          child: _filteredCustomers.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredCustomers.length,
            itemBuilder: (context, index) {
              final customer = _filteredCustomers[index];
              return _buildCustomerCard(customer);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.people_outline,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty
                ? 'No customers found for "$_searchQuery"'
                : 'No customers available',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          if (_searchQuery.isEmpty)
            TextButton(
              onPressed: _openAddCustomer,
              child: const Text(
                'Add First Customer',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showCustomerDetails(customer),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Customer Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Customer Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          customer['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.DarkBlue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: customer['status'] == 'active' ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            customer['status'] == 'active' ? 'Active' : 'Inactive',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customer['phone'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customer['email'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Customer Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${customer['totalSpent']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${customer['totalOrders']} orders',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: customer['currentBalance'] == 0
                          ? Colors.grey
                          : customer['currentBalance'] > 0
                          ? Colors.orange
                          : Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      customer['currentBalance'] == 0
                          ? 'Paid'
                          : customer['currentBalance'] > 0
                          ? 'Due: \$${customer['currentBalance']}'
                          : 'Credit: \$${customer['currentBalance'].abs()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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
}