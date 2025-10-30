// views/expense_tracking/salary_management/salary_dashboard.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';
import 'package:water_app/views/expense_tracking_views/salary_detail.dart';
import 'package:water_app/views/expense_tracking_views/salary_history.dart';

import 'add_salary.dart';


class SalaryDashboardScreen extends StatefulWidget {
  const SalaryDashboardScreen({super.key});

  @override
  State<SalaryDashboardScreen> createState() => _SalaryDashboardScreenState();
}

class _SalaryDashboardScreenState extends State<SalaryDashboardScreen> {
  final List<Map<String, dynamic>> _staffList = [
    {
      'id': '1',
      'name': 'Saif ur Rehman',
      'role': 'Delivery Staff',
      'salary': 15000.0,
      'paid': true,
      'phone': '+92 9876543210',
      'joinDate': '2024-01-15',
      'lastPayment': '2024-02-01',
    },
    {
      'id': '2',
      'name': 'Hamza Younas',
      'role': 'Office Staff',
      'salary': 18000.0,
      'paid': false,
      'phone': '+92 9876543211',
      'joinDate': '2024-02-01',
      'lastPayment': '2024-01-01',
    },
    {
      'id': '3',
      'name': 'Sohaib Saleem',
      'role': 'Delivery Staff',
      'salary': 16000.0,
      'paid': true,
      'phone': '+92 9876543212',
      'joinDate': '2023-12-10',
      'lastPayment': '2024-02-01',
    },
    {
      'id': '4',
      'name': 'Muhammad Hamza',
      'role': 'Manager',
      'salary': 25000.0,
      'paid': false,
      'phone': '+92 9876543213',
      'joinDate': '2023-11-20',
      'lastPayment': '2024-01-01',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salary Management',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SalaryHistoryScreen()),
              );
            },
            icon: const Icon(Icons.history),
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
            MaterialPageRoute(builder: (context) => const AddSalaryScreen()),
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
      child: Column(
        children: [
          Row(
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
                  'Monthly Salary',
                  '74,000',
                  Icons.account_balance_wallet,
                  AppColors.skyBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Paid This Month',
                  '2',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Pending',
                  '2',
                  Icons.pending,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.DarkBlue,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _staffList.length,
        itemBuilder: (context, index) {
          return _buildStaffCard(_staffList[index]);
        },
      ),
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    bool isPaid = staff['paid'] as bool;

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
            Text(
              staff['role'],
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${staff['salary']}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AppColors.DarkBlue,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isPaid ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isPaid ? Colors.green : Colors.orange,
            ),
          ),
          child: Text(
            isPaid ? 'Paid' : 'Pending',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPaid ? Colors.green : Colors.orange,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalaryDetailsScreen(staff: staff),
            ),
          );
        },
      ),
    );
  }
}