import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../res/colors.dart';
import '../drawer_view/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // String _selectedPeriod = 'Monthly';
  // final List<String> _periods = ['Daily', 'Weekly', 'Monthly'];

  // Dashboard Summary Data
  final Map<String, dynamic> _dashboardData = {
    'totalRevenue': 125430.50,
    'totalExpenses': 78450.75,
    'netProfit': 46979.75,
    'totalOrders': 1247,
    'pendingConfirmations': 23,
    'ordersOutForDelivery': 45,
  };

  // Revenue Chart Data
  final List<Map<String, dynamic>> _revenueData = [
    {'period': 'Jan', 'revenue': 45000, 'expenses': 28000, 'profit': 17000},
    {'period': 'Feb', 'revenue': 52000, 'expenses': 32000, 'profit': 20000},
    {'period': 'Mar', 'revenue': 48000, 'expenses': 29000, 'profit': 19000},
    {'period': 'Apr', 'revenue': 61000, 'expenses': 38000, 'profit': 23000},
    {'period': 'May', 'revenue': 55000, 'expenses': 34000, 'profit': 21000},
    {'period': 'Jun', 'revenue': 68000, 'expenses': 42000, 'profit': 26000},
  ];

  // Stock Alerts
  final List<Map<String, dynamic>> _stockAlerts = [
    {
      'productName': "Mineral Water 1L",
      'currentStock': 5,
      'minStockLevel': 20,
      'category': "Beverages"
    },
    {
      'productName': "Glass Bottles",
      'currentStock': 8,
      'minStockLevel': 15,
      'category': "Packaging"
    },
    {
      'productName': "Water Dispensers",
      'currentStock': 3,
      'minStockLevel': 10,
      'category': "Equipment"
    },
    {
      'productName': "5 Gallon Jugs",
      'currentStock': 12,
      'minStockLevel': 25,
      'category': "Containers"
    },
  ];

  // Recent Activities
  final List<Map<String, dynamic>> _recentActivities = [
    {
      'activity': "New order #1247 placed",
      'time': "5 min ago",
      'user': "Customer: John Doe",
      'type': "order"
    },
    {
      'activity': "Payment received for order #1246",
      'time': "15 min ago",
      'user': "Customer: Sarah Smith",
      'type': "payment"
    },
    {
      'activity': "Stock updated - Mineral Water",
      'time': "1 hour ago",
      'user': "Admin: You",
      'type': "stock"
    },
    {
      'activity': "New delivery agent registered",
      'time': "2 hours ago",
      'user': "Agent: Mike Johnson",
      'type': "user"
    },
    {
      'activity': "Monthly report generated",
      'time': "3 hours ago",
      'user': "System",
      'type': "report"
    },
  ];

  // Quick Stats
  final List<Map<String, dynamic>> _quickStats = [
    {'title': 'Today\'s Orders', 'value': '47', 'change': '+12%', 'isPositive': true},
    {'title': 'Revenue Today', 'value': '\$3,847000', 'change': '+8%', 'isPositive': true},
    {'title': 'Active Deliveries', 'value': '18', 'change': '-2%', 'isPositive': false},
    {'title': 'Customer Satisfaction', 'value': '94%', 'change': '+3%', 'isPositive': true},
  ];

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_cart;
      case 'payment':
        return Icons.payment;
      case 'stock':
        return Icons.inventory;
      case 'user':
        return Icons.person_add;
      case 'report':
        return Icons.assessment;
      default:
        return Icons.notifications;
    }
  }

  Color _getStockAlertColor(int currentStock, int minStock) {
    if (currentStock <= 5) return Colors.red;
    if (currentStock <= minStock * 0.5) return Colors.orange;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.primaryBlue),
            onPressed: () {},
          ),
        ],
      ),
        drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            // _buildPeriodSelector(),
            // const SizedBox(height: 10),

            // Quick Stats Cards
            _buildQuickStats(),
            const SizedBox(height: 20),

            // Main Metrics Cards
            _buildMainMetrics(),
            const SizedBox(height: 20),

            // Revenue Chart
            _buildRevenueChart(),
            const SizedBox(height: 20),

            // Stock Alerts & Recent Activity
            _buildStockAlerts(),
            const SizedBox(height: 20),
            _buildRecentActivity(),

          ],
        ),
      ),
    );
  }

  // Widget _buildPeriodSelector() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       const Text(
  //         'Business Overview',
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //           color: AppColors.DarkBlue,
  //         ),
  //       ),
  //       Container(
  //         height: 35,
  //         padding: const EdgeInsets.symmetric(horizontal: 12),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: AppColors.lightSkyBlue),
  //         ),
  //         child: DropdownButton<String>(
  //           value: _selectedPeriod,
  //           underline: const SizedBox(),
  //           items: _periods.map((String period) {
  //             return DropdownMenuItem<String>(
  //               value: period,
  //               child: Text(
  //                 period,
  //                 style: const TextStyle(
  //                   color: AppColors.primaryBlue,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               _selectedPeriod = newValue!;
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildQuickStats() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.2,
      ),
      itemCount: _quickStats.length,
      itemBuilder: (context, index) {
        final stat = _quickStats[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat['title'],
                style: const TextStyle(
                  color: AppColors.DarkBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stat['value'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: stat['isPositive'] ? Colors.green.shade50 : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      stat['change'],
                      style: TextStyle(
                        color: stat['isPositive'] ? Colors.green : Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainMetrics() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.assessment, color: AppColors.primaryBlue),
              SizedBox(width: 8),
              Text(
                'Financial Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildMetricCard(
                'Total Revenue',
                '\$${_dashboardData['totalRevenue'].toStringAsFixed(2)}',
                Icons.trending_up,
                Colors.green,
              ),
              const SizedBox(width: 16),
              _buildMetricCard(
                'Total Expenses',
                '\$${_dashboardData['totalExpenses'].toStringAsFixed(2)}',
                Icons.trending_down,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetricCard(
                'Net Profit',
                '\$${_dashboardData['netProfit'].toStringAsFixed(2)}',
                Icons.account_balance_wallet,
                AppColors.primaryBlue,
              ),
              const SizedBox(width: 16),
              _buildMetricCard(
                'Total Orders',
                _dashboardData['totalOrders'].toString(),
                Icons.shopping_cart,
                AppColors.skyBlue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetricCard(
                'Pending Confirmations',
                _dashboardData['pendingConfirmations'].toString(),
                Icons.pending_actions,
                Colors.amber,
              ),
              const SizedBox(width: 16),
              _buildMetricCard(
                'Out for Delivery',
                _dashboardData['ordersOutForDelivery'].toString(),
                Icons.local_shipping,
                AppColors.secondaryBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.DarkBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.DarkBlue,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <CartesianSeries>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: _revenueData,
                  xValueMapper: (data, _) => data['period'],
                  yValueMapper: (data, _) => data['revenue'],
                  name: 'Revenue',
                  color: AppColors.primaryBlue,
                ),
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: _revenueData,
                  xValueMapper: (data, _) => data['period'],
                  yValueMapper: (data, _) => data['expenses'],
                  name: 'Expenses',
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockAlerts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange),
              const SizedBox(width: 8),
              const Text(
                'Low Stock Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _stockAlerts.length.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._stockAlerts.map((alert) => _buildStockAlertItem(alert)).toList(),
        ],
      ),
    );
  }

  Widget _buildStockAlertItem(Map<String, dynamic> alert) {
    final color = _getStockAlertColor(alert['currentStock'], alert['minStockLevel']);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['productName'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkBlue,
                  ),
                ),
                Text(
                  'Stock: ${alert['currentStock']} / ${alert['minStockLevel']}',
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
                Text(
                  alert['category'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () {},
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.history, color: AppColors.primaryBlue),
              SizedBox(width: 8),
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recentActivities.map((activity) => _buildActivityItem(activity)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getActivityIcon(activity['type']),
            color: AppColors.primaryBlue,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['activity'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.DarkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['user'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  activity['time'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}