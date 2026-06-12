import 'package:flutter/material.dart';
import 'package:water_app/views/auth_views/login_view.dart';
import 'package:water_app/views/drawer_view/drawer_expension_tile.dart';
import 'package:water_app/views/drawer_view/drawer_sub_items.dart';
import '../../res/colors.dart';
import '../customer_management/customer_list.dart';
import '../delivery_management_views/assigne_order.dart';
import '../delivery_management_views/delivery_staff.dart';
import '../delivery_management_views/delivery_status.dart';
import '../delivery_management_views/delivery_zones.dart';
import '../expense_tracking_views/expense_categories.dart';
import '../expense_tracking_views/expense_dashboard.dart';
import '../expense_tracking_views/expense_record.dart';
import '../expense_tracking_views/salary_dashboard.dart';
import '../orders_management_view/order_history.dart';
import '../orders_management_view/view_all_orders.dart';
import '../product_view/product_catalog_view/product_catalog.dart';
import '../product_view/stock_management/low_stock.dart';
import '../product_view/stock_management/stock_management.dart';
import 'darwer_items.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          _buildDrawerHeader(),

          // Dashboard
          DrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () {
              Navigator.pop(context);
              // Navigate to dashboard
            },
          ),

          // Orders Management
          DrawerExpansionTile(
            icon: Icons.shopping_cart,
            title: 'Orders Management',
            children: [
              DrawerSubItem(
                title: 'View All Orders',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigate to all orders
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAllOrdersScreen(),
                    ),
                  );
                },
              ),
              // DrawerSubItem(
              //   title: 'Pending Confirmations',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigate to pending orders
              //   },
              // ),
              // DrawerSubItem(
              //   title: 'Assign to Delivery',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigate to assign orders
              //   },
              // ),
              DrawerSubItem(
                title: 'Order History',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigate to order history
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderHistoryScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Customer Management
          DrawerExpansionTile(
            icon: Icons.people,
            title: 'Customer Management',
            children: [
              DrawerSubItem(
                title: 'Customer List',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigate to customer list
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomersScreen()),
                  );
                },
              ),
              DrawerSubItem(
                title: 'Dues & Credits',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to dues
                },
              ),
            ],
          ),

          // Product Management
          DrawerExpansionTile(
            icon: Icons.inventory,
            title: 'Product Management',
            children: [
              DrawerSubItem(
                title: 'Product Catalog',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigate to products
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductCatalogScreen(),
                    ),
                  );
                },
              ),
              // DrawerSubItem(
              //   title: 'Add New Product',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigate to add product
              //   },
              // ),
              // DrawerSubItem(
              //   title: 'Update Pricing',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigate to pricing
              //   },
              // ),
              DrawerSubItem(
                title: 'Stock Management',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigate to stock
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockManagementScreen(),
                    ),
                  );
                },
              ),
              DrawerSubItem(
                title: 'Low Stock Alerts',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to low stock
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LowStockAlertScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Expense Tracking
          DrawerExpansionTile(
            icon: Icons.account_balance_wallet,
            title: 'Expense Tracking',
            children: [
              DrawerSubItem(
                title: 'Expense Dashboard',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseDashboardScreen(),
                    ),
                  );
                  // Navigate to record expense
                },
              ),
              DrawerSubItem(
                title: 'Record Expense',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecordExpenseScreen(),
                    ),
                  );
                  // Navigate to record expense
                },
              ),
              DrawerSubItem(
                title: 'Fuel Expenses',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to fuel expenses
                },
              ),
              DrawerSubItem(
                title: 'Salary Management',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SalaryDashboardScreen(),
                    ),
                  );
                },
              ),
              DrawerSubItem(
                title: 'Rent & Utilities',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to rent
                },
              ),
              DrawerSubItem(
                title: 'Packaging Costs',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to packaging
                },
              ),
              DrawerSubItem(
                title: 'Expense Categories',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpenseCategoriesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Reports
          DrawerExpansionTile(
            icon: Icons.analytics,
            title: 'Reports & Analytics',
            children: [
              DrawerSubItem(
                title: 'Sales Reports',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to sales reports
                },
              ),
              DrawerSubItem(
                title: 'Expense Reports',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to expense reports
                },
              ),
              DrawerSubItem(
                title: 'Profit & Loss',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to P&L
                },
              ),
              DrawerSubItem(
                title: 'Customer Insights',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to customer analytics
                },
              ),
            ],
          ),

          // Staff/Delivery Management
          DrawerExpansionTile(
            icon: Icons.local_shipping,
            title: 'Delivery Management',
            children: [
              DrawerSubItem(
                title: 'Delivery Staff',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryStaffScreen(),
                    ),
                  );
                },
              ),
              DrawerSubItem(
                title: 'Assign Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignOrdersScreen(),
                    ),
                  );
                },
              ),
              DrawerSubItem(
                title: 'Delivery Status',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryStatusScreen(),
                    ),
                  );
                },
              ),
              // DrawerSubItem(
              //   title: 'Performance Metrics',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigate to performance
              //   },
              // ),
              DrawerSubItem(
                title: 'Delivery Zones',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryZonesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Settings
          DrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),

          // Help & Support
          DrawerItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              // Navigate to help
            },
          ),

          // Logout
          DrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryBlue, AppColors.skyBlue],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.water_drop,
              color: AppColors.primaryBlue,
              size: 35,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Aqua Manager',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Admin Panel',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              color: AppColors.DarkBlue,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: AppColors.DarkBlue, fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.skyBlue,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.errorRed,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
