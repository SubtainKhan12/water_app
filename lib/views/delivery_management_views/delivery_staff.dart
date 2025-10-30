// views/delivery_management/delivery_staff.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';
import 'add_delivery_staff.dart';
import 'delivery_staff_detail.dart';

class DeliveryStaffScreen extends StatefulWidget {
  const DeliveryStaffScreen({super.key});

  @override
  State<DeliveryStaffScreen> createState() => _DeliveryStaffScreenState();
}

class _DeliveryStaffScreenState extends State<DeliveryStaffScreen> {
  final List<Map<String, dynamic>> _deliveryStaff = [
    {
      'id': '1',
      'name': 'Ahmed Raza',
      'phone': '+92 300 1234567',
      'vehicle': 'Bike - LEA 1234',
      'zone': 'Gulberg, Lahore',
      'status': 'Active',
      'ordersToday': 12,
      'rating': 4.7,
      'image': '',
    },
    {
      'id': '2',
      'name': 'Bilal Khan',
      'phone': '+92 301 2345678',
      'vehicle': 'Bike - LEB 5678',
      'zone': 'DHA, Karachi',
      'status': 'Active',
      'ordersToday': 9,
      'rating': 4.3,
      'image': '',
    },
    {
      'id': '3',
      'name': 'Usman Ali',
      'phone': '+92 302 3456789',
      'vehicle': 'Bike - ISB 9012',
      'zone': 'F-7, Islamabad',
      'status': 'On Break',
      'ordersToday': 5,
      'rating': 4.8,
      'image': '',
    },
    {
      'id': '4',
      'name': 'Zain Malik',
      'phone': '+92 303 4567890',
      'vehicle': 'Bike - RWP 3456',
      'zone': 'Saddar, Rawalpindi',
      'status': 'Offline',
      'ordersToday': 0,
      'rating': 4.2,
      'image': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Staff',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // Filter options
              _showFilterDialog();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          _buildSummaryCards(),
          const SizedBox(height: 16),

          // Staff List
          _buildStaffList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDeliveryStaffScreen()),
          );
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Staff',
              '4',
              Icons.people,
              AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Active Today',
              '3',
              Icons.directions_bike,
              Colors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Total Orders',
              '26',
              Icons.local_shipping,
              AppColors.skyBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
          ),
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _deliveryStaff.length,
        itemBuilder: (context, index) {
          return _buildStaffCard(_deliveryStaff[index]);
        },
      ),
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    Color statusColor = _getStatusColor(staff['status']);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.skyBlue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            color: AppColors.primaryBlue,
            size: 24,
          ),
        ),
        title: Text(
          staff['name'],
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              staff['vehicle'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              '${staff['ordersToday']} orders today • ${staff['rating']} ⭐',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                staff['status'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              staff['zone'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryStaffDetailsScreen(staff: staff),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'On Break':
        return Colors.orange;
      case 'Offline':
        return Colors.grey;
      default:
        return AppColors.primaryBlue;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Filter Staff',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Active Only', true),
            _buildFilterOption('Show Offline', false),
            _buildFilterOption('High Rating (4.0+)', true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String text, bool value) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {},
        ),
        Text(text, style: const TextStyle(fontFamily: 'Poppins')),
      ],
    );
  }
}