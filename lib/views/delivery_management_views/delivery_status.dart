// views/delivery_management/delivery_status.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class DeliveryStatusScreen extends StatefulWidget {
  const DeliveryStatusScreen({super.key});

  @override
  State<DeliveryStatusScreen> createState() => _DeliveryStatusScreenState();
}

class _DeliveryStatusScreenState extends State<DeliveryStatusScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Pending',
    'In Progress',
    'Delivered',
    'Cancelled',
  ];

  final List<Map<String, dynamic>> _deliveries = [
    {
      'id': '1001',
      'customer': 'Ali Ahmed',
      'address': 'House 45, Street 8, Gulberg, Lahore',
      'deliveryStaff': 'Ahmed Raza',
      'status': 'In Progress',
      'time': '10:30 AM',
      'phone': '+92 300 1234567',
      'items': '5 bottles',
      'amount': 'PKR 500',
      'estimatedTime': '11:00 AM',
    },
    {
      'id': '1002',
      'customer': 'Fatima Khan',
      'address': 'Office 23, Main Boulevard, DHA, Lahore',
      'deliveryStaff': 'Bilal Khan',
      'status': 'Pending',
      'time': '11:15 AM',
      'phone': '+92 301 2345678',
      'items': '3 bottles',
      'amount': 'PKR 300',
      'estimatedTime': '12:00 PM',
    },
    {
      'id': '1003',
      'customer': 'Usman Malik',
      'address': 'Shop 67, Model Town Link Road, Lahore',
      'deliveryStaff': 'Usman Ali',
      'status': 'Delivered',
      'time': '09:45 AM',
      'phone': '+92 302 3456789',
      'items': '10 bottles',
      'amount': 'PKR 1000',
      'estimatedTime': '10:30 AM',
    },
    {
      'id': '1004',
      'customer': 'Sara Khan',
      'address': 'House 12, Street 5, Bahria Town, Lahore',
      'deliveryStaff': 'Ahmed Raza',
      'status': 'In Progress',
      'time': '01:30 PM',
      'phone': '+92 303 4567890',
      'items': '8 bottles',
      'amount': 'PKR 800',
      'estimatedTime': '02:15 PM',
    },
    {
      'id': '1005',
      'customer': 'Omar Farooq',
      'address': 'Apartment 34, F-7, Islamabad',
      'deliveryStaff': 'Zain Malik',
      'status': 'Cancelled',
      'time': '12:00 PM',
      'phone': '+92 304 5678901',
      'items': '6 bottles',
      'amount': 'PKR 600',
      'estimatedTime': '01:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDeliveries = _selectedFilter == 'All'
        ? _deliveries
        : _deliveries
              .where((delivery) => delivery['status'] == _selectedFilter)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Status',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterChips(),
          const SizedBox(height: 8),

          // Summary Cards
          _buildSummaryCards(),
          const SizedBox(height: 8),

          // Delivery List
          _buildDeliveryList(filteredDeliveries),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                filter,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: _selectedFilter == filter
                      ? Colors.white
                      : AppColors.primaryBlue,
                ),
              ),
              selected: _selectedFilter == filter,
              onSelected: (bool selected) {
                setState(() {
                  _selectedFilter = selected ? filter : 'All';
                });
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primaryBlue,
              checkmarkColor: Colors.white,
              side: BorderSide(color: AppColors.primaryBlue),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards() {
    final pendingCount = _deliveries
        .where((d) => d['status'] == 'Pending')
        .length;
    final inProgressCount = _deliveries
        .where((d) => d['status'] == 'In Progress')
        .length;
    final deliveredCount = _deliveries
        .where((d) => d['status'] == 'Delivered')
        .length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Pending',
              pendingCount.toString(),
              Icons.pending,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'In Progress',
              inProgressCount.toString(),
              Icons.directions_bike,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Delivered',
              deliveredCount.toString(),
              Icons.check_circle,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.DarkBlue,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryList(List<Map<String, dynamic>> deliveries) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return _buildDeliveryCard(deliveries[index]);
        },
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    Color statusColor = _getStatusColor(delivery['status']);
    IconData statusIcon = _getStatusIcon(delivery['status']);

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
                  'Order #${delivery['id']}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        delivery['status'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Customer: ${delivery['customer']}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              delivery['address'],
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Staff: ${delivery['deliveryStaff']}',
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
                const Spacer(),
                const Icon(Icons.phone, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  delivery['phone'],
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      delivery['items'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      delivery['amount'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AppColors.DarkBlue,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Order Time: ${delivery['time']}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Est. Delivery: ${delivery['estimatedTime']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: delivery['status'] == 'Delivered'
                            ? Colors.green
                            : AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (delivery['status'] == 'In Progress') ...[
              const SizedBox(height: 12),
              _buildProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Progress',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.6,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Prepared',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.green,
              ),
            ),
            Text(
              'On the way (60%)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: AppColors.primaryBlue,
              ),
            ),
            Text(
              'Delivered',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.pending;
      case 'In Progress':
        return Icons.directions_bike;
      case 'Delivered':
        return Icons.check_circle;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.local_shipping;
    }
  }
}
