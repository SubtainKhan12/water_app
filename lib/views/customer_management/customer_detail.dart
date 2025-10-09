// lib/views/customers/customer_details_screen.dart
import 'package:flutter/material.dart';
import 'package:water_app/views/customer_management/update_customer.dart';
import '../../res/colors.dart';
import '../../res/widgets/round_button.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample order history data
  final List<Map<String, dynamic>> _orderHistory = [
    {
      'id': '#1247',
      'date': '2024-01-20',
      'products': 'Mineral Water 1L x 5, 5 Gallon x 2',
      'amount': 45.50,
      'status': 'delivered',
      'paymentStatus': 'paid',
    },
    {
      'id': '#1240',
      'date': '2024-01-15',
      'products': '5 Gallon x 3',
      'amount': 45.00,
      'status': 'delivered',
      'paymentStatus': 'paid',
    },
    {
      'id': '#1235',
      'date': '2024-01-10',
      'products': 'Water Dispenser x 1',
      'amount': 80.00,
      'status': 'delivered',
      'paymentStatus': 'due',
    },
  ];

  // Sample transaction history
  final List<Map<String, dynamic>> _transactions = [
    {
      'date': '2024-01-20',
      'type': 'order_payment',
      'description': 'Payment for order #1247',
      'amount': 45.50,
      'balance': 0.00,
    },
    {
      'date': '2024-01-15',
      'type': 'order',
      'description': 'New order #1240',
      'amount': -45.00,
      'balance': -45.50,
    },
    {
      'date': '2024-01-10',
      'type': 'credit_payment',
      'description': 'Credit payment received',
      'amount': 100.00,
      'balance': -0.50,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.customer['name'],
          style: const TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCustomerScreen(customer: widget.customer),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryBlue,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Orders'),
            Tab(text: 'Transactions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCustomerDetails(),
          _buildOrderHistory(),
          _buildTransactionHistory(),
        ],
      ),
    );
  }

  Widget _buildCustomerDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Customer Summary Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryBlue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.customer['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.DarkBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: widget.customer['status'] == 'active' ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.customer['status'] == 'active' ? 'Active Customer' : 'Inactive',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Total Orders', widget.customer['totalOrders'].toString()),
                      _buildStatItem('Total Spent', '\$${widget.customer['totalSpent']}'),
                      _buildStatItem('Since', widget.customer['joinDate']),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Balance Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Balance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.DarkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Balance:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '\$${widget.customer['currentBalance']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.customer['currentBalance'] == 0
                              ? Colors.grey
                              : widget.customer['currentBalance'] > 0
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contact Information
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.DarkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Phone', widget.customer['phone']),
                  _buildDetailItem('Email', widget.customer['email']),
                  _buildDetailItem('Address', widget.customer['address']),
                  _buildDetailItem('Member Since', widget.customer['joinDate']),
                  _buildDetailItem('Last Order', widget.customer['lastOrderDate']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistory() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orderHistory.length,
      itemBuilder: (context, index) {
        final order = _orderHistory[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.DarkBlue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: order['paymentStatus'] == 'paid' ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        order['paymentStatus'] == 'paid' ? 'Paid' : 'Due',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  order['products'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['date'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${order['amount']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionHistory() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        final isCredit = transaction['amount'] > 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCredit ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isCredit ? Colors.green : Colors.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['description'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.DarkBlue,
                        ),
                      ),
                      Text(
                        transaction['date'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isCredit ? '+\$${transaction['amount']}' : '-\$${transaction['amount'].abs()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCredit ? Colors.green : Colors.orange,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Balance: \$${transaction['balance']}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.DarkBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}