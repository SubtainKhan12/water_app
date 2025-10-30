// views/delivery_management/delivery_zones.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

import 'add_delivery_zone.dart';
import 'edit_delivery_zone.dart';

class DeliveryZonesScreen extends StatefulWidget {
  const DeliveryZonesScreen({super.key});

  @override
  State<DeliveryZonesScreen> createState() => _DeliveryZonesScreenState();
}

class _DeliveryZonesScreenState extends State<DeliveryZonesScreen> {
  final List<Map<String, dynamic>> _zones = [
    {
      'id': '1',
      'name': 'Gulberg, Lahore',
      'area': '15 sq km',
      'deliveryTime': '30-45 mins',
      'deliveryCharge': 'PKR 50',
      'activeStaff': 3,
      'totalOrders': 45,
      'status': 'Active',
      'color': Colors.blue,
      'areas': ['Gulberg III', 'Gulberg IV', 'Gulberg V', 'Main Boulevard'],
    },
    {
      'id': '2',
      'name': 'DHA, Lahore',
      'area': '25 sq km',
      'deliveryTime': '45-60 mins',
      'deliveryCharge': 'PKR 75',
      'activeStaff': 4,
      'totalOrders': 62,
      'status': 'Active',
      'color': Colors.green,
      'areas': ['DHA Phase 1', 'DHA Phase 2', 'DHA Phase 3', 'DHA Phase 4'],
    },
    {
      'id': '3',
      'name': 'Model Town, Lahore',
      'area': '12 sq km',
      'deliveryTime': '25-40 mins',
      'deliveryCharge': 'PKR 40',
      'activeStaff': 2,
      'totalOrders': 28,
      'status': 'Active',
      'color': Colors.orange,
      'areas': ['Model Town A', 'Model Town B', 'Model Town C', 'Link Road'],
    },
    {
      'id': '4',
      'name': 'F-7, Islamabad',
      'area': '8 sq km',
      'deliveryTime': '35-50 mins',
      'deliveryCharge': 'PKR 60',
      'activeStaff': 1,
      'totalOrders': 18,
      'status': 'Active',
      'color': Colors.purple,
      'areas': ['F-7/1', 'F-7/2', 'F-7/3', 'F-7/4'],
    },
    {
      'id': '5',
      'name': 'Clifton, Karachi',
      'area': '20 sq km',
      'deliveryTime': '40-55 mins',
      'deliveryCharge': 'PKR 70',
      'activeStaff': 3,
      'totalOrders': 35,
      'status': 'Inactive',
      'color': Colors.red,
      'areas': ['Clifton Block 1', 'Clifton Block 2', 'Sea View', 'Do Talwar'],
    },
    {
      'id': '6',
      'name': 'University Road, Peshawar',
      'area': '10 sq km',
      'deliveryTime': '30-45 mins',
      'deliveryCharge': 'PKR 45',
      'activeStaff': 1,
      'totalOrders': 15,
      'status': 'Active',
      'color': Colors.teal,
      'areas': ['University Town', 'Professors Colony', 'Khyber Road'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Zones',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDeliveryZoneScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          _buildSummaryCards(),
          const SizedBox(height: 16),

          // Zones List
          _buildZonesList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    final activeZones = _zones.where((zone) => zone['status'] == 'Active').length;
    final totalStaff = _zones.fold<int>(0, (sum, zone) => sum + (zone['activeStaff'] as int));
    final totalOrders = _zones.fold<int>(0, (sum, zone) => sum + (zone['totalOrders'] as int));

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard('Active Zones', activeZones.toString(), Icons.location_on, AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard('Total Staff', totalStaff.toString(), Icons.people, Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard('Today\'s Orders', totalOrders.toString(), Icons.local_shipping, Colors.orange),
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

  Widget _buildZonesList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _zones.length,
        itemBuilder: (context, index) {
          return _buildZoneCard(_zones[index]);
        },
      ),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    bool isActive = zone['status'] == 'Active';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: zone['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: zone['color'],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        zone['name'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildZoneInfo('Area: ${zone['area']}'),
                          // _buildZoneInfo('Staff: ${zone['activeStaff']}'),
                          _buildZoneInfo('Orders: ${zone['totalOrders']}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isActive ? Colors.green : Colors.red),
                  ),
                  child: Text(
                    zone['status'],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            // Delivery Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDeliveryDetail('Delivery Time', zone['deliveryTime'], Icons.access_time),
                _buildDeliveryDetail('Delivery Charge', zone['deliveryCharge'], Icons.attach_money),
              ],
            ),
            const SizedBox(height: 12),
            // Sub Areas
            _buildSubAreas(zone['areas']),
            const SizedBox(height: 12),
            // Action Buttons
            _buildActionButtons(zone),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneInfo(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildDeliveryDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryBlue),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubAreas(List<String> areas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Covered Areas:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: areas.map((area) {
            return Chip(
              label: Text(
                area,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                ),
              ),
              backgroundColor: AppColors.skyBlue.withOpacity(0.2),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> zone) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDeliveryZoneScreen(zone: zone),
                ),
              ).then((updatedZone) {
                if (updatedZone != null) {
                  setState(() {
                    final index = _zones.indexWhere((z) => z['id'] == zone['id']);
                    if (index != -1) {
                      _zones[index] = updatedZone;
                    }
                  });
                }
              });
            },
            icon: const Icon(Icons.edit, size: 16),
            label: const Text(
              'Edit',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _toggleZoneStatus(zone),
            icon: Icon(
              zone['status'] == 'Active' ? Icons.pause : Icons.play_arrow,
              size: 16,
            ),
            label: Text(
              zone['status'] == 'Active' ? 'Pause' : 'Activate',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: zone['status'] == 'Active' ? Colors.orange : Colors.green,
              side: BorderSide(
                color: zone['status'] == 'Active' ? Colors.orange : Colors.green,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _viewZoneDetails(zone),
            icon: const Icon(Icons.visibility, size: 16),
            label: const Text(
              'View',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              side: const BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }


  void _toggleZoneStatus(Map<String, dynamic> zone) {
    setState(() {
      zone['status'] = zone['status'] == 'Active' ? 'Inactive' : 'Active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Zone ${zone['name']} ${zone['status'] == 'Active' ? 'activated' : 'paused'}'),
        backgroundColor: zone['status'] == 'Active' ? Colors.green : Colors.orange,
      ),
    );
  }

  void _viewZoneDetails(Map<String, dynamic> zone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Zone Details - ${zone['name']}',
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Zone Name', zone['name']),
              _buildDetailRow('Area Coverage', zone['area']),
              _buildDetailRow('Delivery Time', zone['deliveryTime']),
              _buildDetailRow('Delivery Charge', zone['deliveryCharge']),
              _buildDetailRow('Active Staff', zone['activeStaff'].toString()),
              _buildDetailRow('Total Orders Today', zone['totalOrders'].toString()),
              _buildDetailRow('Status', zone['status']),
              const SizedBox(height: 16),
              const Text(
                'Covered Areas:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...zone['areas'].map((area) => Text(
                '• $area',
                style: const TextStyle(fontFamily: 'Poppins'),
              )).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}