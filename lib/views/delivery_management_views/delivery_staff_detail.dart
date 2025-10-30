// views/delivery_management/delivery_staff_details.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class DeliveryStaffDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> staff;

  const DeliveryStaffDetailsScreen({super.key, required this.staff});

  @override
  State<DeliveryStaffDetailsScreen> createState() => _DeliveryStaffDetailsScreenState();
}

class _DeliveryStaffDetailsScreenState extends State<DeliveryStaffDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Staff Details - ${widget.staff['name']}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _editStaff,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Staff Info Card
            _buildStaffInfoCard(),
            const SizedBox(height: 20),

            // Performance Stats
            _buildPerformanceStats(),
            const SizedBox(height: 20),

            // Today's Orders
            _buildTodaysOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffInfoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.skyBlue.withOpacity(0.2),
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
                        widget.staff['name'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.staff['phone'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        widget.staff['vehicle'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    widget.staff['status'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('Delivery Zone', widget.staff['zone']),
                _buildInfoItem('Total Orders', '${widget.staff['ordersToday']} today'),
                _buildInfoItem('Rating', '${widget.staff['rating']} ⭐'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.DarkBlue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceStats() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Stats - This Month',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Completed', '156', Icons.check_circle, Colors.green),
                _buildStatItem('Pending', '8', Icons.pending, Colors.orange),
                _buildStatItem('Cancelled', '3', Icons.cancel, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysOrders() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Orders",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildOrderItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    List<Map<String, dynamic>> sampleOrders = [
      {'status': 'Delivered', 'address': 'House 123, Street 5, Gulberg', 'time': '10:30 AM'},
      {'status': 'In Progress', 'address': 'Office 45, Main Boulevard', 'time': '11:15 AM'},
      {'status': 'Pending', 'address': 'Shop 67, Market Road', 'time': '12:00 PM'},
      {'status': 'Delivered', 'address': 'Apartment 89, Garden Town', 'time': '09:45 AM'},
      {'status': 'In Progress', 'address': 'House 21, Model Town', 'time': '01:30 PM'},
    ];

    final order = sampleOrders[index];
    Color statusColor = _getOrderStatusColor(order['status']);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getOrderStatusIcon(order['status']),
            color: statusColor,
            size: 20,
          ),
        ),
        title: Text(
          'Order #${1000 + index}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          order['address'],
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              order['time'],
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order['status'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Pending':
        return Colors.blue;
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _getOrderStatusIcon(String status) {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.directions_bike;
      case 'Pending':
        return Icons.access_time;
      default:
        return Icons.local_shipping;
    }
  }

  void _editStaff() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Staff Details',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Staff Name',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: widget.staff['name']),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: widget.staff['phone']),
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
              // Update staff logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Staff details updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}