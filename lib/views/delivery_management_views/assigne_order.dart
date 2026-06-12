// views/delivery_management/assign_orders.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class AssignOrdersScreen extends StatefulWidget {
  const AssignOrdersScreen({super.key});

  @override
  State<AssignOrdersScreen> createState() => _AssignOrdersScreenState();
}

class _AssignOrdersScreenState extends State<AssignOrdersScreen> {
  final List<Map<String, dynamic>> _pendingOrders = [
    {
      'id': '1001',
      'customer': 'Ali Ahmed',
      'address': 'House 45, Street 8, Gulberg, Lahore',
      'items': '5 bottles',
      'amount': 'PKR 500',
      'priority': 'High',
      'zone': 'Gulberg, Lahore',
    },
    {
      'id': '1002',
      'customer': 'Fatima Khan',
      'address': 'Office 23, Main Boulevard, DHA',
      'items': '3 bottles',
      'amount': 'PKR 300',
      'priority': 'Medium',
      'zone': 'DHA, Lahore',
    },
    {
      'id': '1003',
      'customer': 'Usman Malik',
      'address': 'Shop 67, Model Town Link Road',
      'items': '10 bottles',
      'amount': 'PKR 1000',
      'priority': 'High',
      'zone': 'Model Town, Lahore',
    },
  ];

  final List<Map<String, dynamic>> _availableStaff = [
    {
      'id': '1',
      'name': 'Ahmed Raza',
      'currentOrders': 2,
      'zone': 'Gulberg, Lahore',
      'rating': 4.7,
    },
    {
      'id': '2',
      'name': 'Bilal Khan',
      'currentOrders': 1,
      'zone': 'DHA, Lahore',
      'rating': 4.3,
    },
    {
      'id': '3',
      'name': 'Usman Ali',
      'currentOrders': 0,
      'zone': 'Model Town, Lahore',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assign Orders',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Pending Orders
          _buildPendingOrdersSection(),

          // Available Staff
          _buildAvailableStaffSection(),
        ],
      ),
    );
  }

  Widget _buildPendingOrdersSection() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pending Orders - Ready for Assignment',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _pendingOrders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(_pendingOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color priorityColor = _getPriorityColor(order['priority']);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: priorityColor),
                  ),
                  child: Text(
                    order['priority'],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Customer: ${order['customer']}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              order['address'],
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['items'],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  order['amount'],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showAssignDialog(order),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'Assign to Delivery',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableStaffSection() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Available Delivery Staff',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _availableStaff.length,
                itemBuilder: (context, index) {
                  return _buildStaffCard(_availableStaff[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.skyBlue.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
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
                      staff['name'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${staff['currentOrders']} orders',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            staff['zone'],
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                staff['rating'].toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return AppColors.primaryBlue;
    }
  }

  void _showAssignDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Assign Order',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order #${order['id']}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer: ${order['customer']}',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Delivery Staff:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ..._availableStaff.map((staff) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(staff['name'], style: const TextStyle(fontFamily: 'Poppins')),
                subtitle: Text(staff['zone'], style: const TextStyle(fontFamily: 'Poppins')),
                trailing: Text('${staff['rating']} ⭐', style: const TextStyle(fontFamily: 'Poppins')),
                onTap: () {
                  _assignOrder(order, staff);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _assignOrder(Map<String, dynamic> order, Map<String, dynamic> staff) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order #${order['id']} assigned to ${staff['name']}'),
        backgroundColor: Colors.green,
      ),
    );

    // Remove the assigned order from pending list
    setState(() {
      _pendingOrders.remove(order);
    });
  }
}