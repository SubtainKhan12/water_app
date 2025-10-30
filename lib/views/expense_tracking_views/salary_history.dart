// views/expense_tracking/salary_management/salary_history.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class SalaryHistoryScreen extends StatefulWidget {
  const SalaryHistoryScreen({super.key});

  @override
  State<SalaryHistoryScreen> createState() => _SalaryHistoryScreenState();
}

class _SalaryHistoryScreenState extends State<SalaryHistoryScreen> {
  String _selectedMonth = 'February 2024';

  final List<Map<String, dynamic>> _salaryHistory = [
    {
      'month': 'February 2024',
      'totalPaid': 31000.0,
      'staffCount': 2,
      'payments': [
        {
          'name': 'Rajesh Kumar',
          'amount': 15000.0,
          'date': '2024-02-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
        {
          'name': 'Amit Singh',
          'amount': 16000.0,
          'date': '2024-02-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
      ],
    },
    {
      'month': 'January 2024',
      'totalPaid': 58000.0,
      'staffCount': 4,
      'payments': [
        {
          'name': 'Rajesh Kumar',
          'amount': 15000.0,
          'date': '2024-01-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
        {
          'name': 'Priya Sharma',
          'amount': 18000.0,
          'date': '2024-01-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
        {
          'name': 'Amit Singh',
          'amount': 16000.0,
          'date': '2024-01-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
        {
          'name': 'Sneha Patel',
          'amount': 25000.0,
          'date': '2024-01-01',
          'method': 'Bank Transfer',
          'status': 'Paid',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentMonthData = _salaryHistory.firstWhere(
          (element) => element['month'] == _selectedMonth,
      orElse: () => _salaryHistory.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salary History',
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
          // Month Selector
          _buildMonthSelector(),

          // Summary
          _buildMonthSummary(currentMonthData),

          // Payment List
          _buildPaymentList(currentMonthData),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: DropdownButtonFormField<String>(
        value: _selectedMonth,
        items: _salaryHistory.map((Map<String, dynamic> history) {
          return DropdownMenuItem<String>(
            value: history['month'],
            child: Text(
              history['month'],
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedMonth = newValue!;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Select Month',
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  Widget _buildMonthSummary(Map<String, dynamic> monthData) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Total Paid', '${monthData['totalPaid']}'),
          _buildSummaryItem('Staff', monthData['staffCount'].toString()),
          _buildSummaryItem('Payments', monthData['payments'].length.toString()),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
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
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentList(Map<String, dynamic> monthData) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: monthData['payments'].length,
        itemBuilder: (context, index) {
          final payment = monthData['payments'][index];
          return _buildPaymentCard(payment);
        },
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, color: Colors.green),
        ),
        title: Text(
          payment['name'],
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
              'Date: ${payment['date']}',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'Method: ${payment['method']}',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${payment['amount']}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AppColors.DarkBlue,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                payment['status'],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}