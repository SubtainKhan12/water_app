// lib/views/customers/edit_customer_screen.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/widgets/round_button.dart';

class EditCustomerScreen extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _customerType = 'Regular';
  String _customerStatus = 'active';
  final List<String> _customerTypes = ['Regular', 'Premium', 'Corporate', 'VIP'];
  final List<String> _statusOptions = ['active', 'inactive'];

  @override
  void initState() {
    super.initState();
    // Initialize form with existing customer data
    _initializeForm();
  }

  void _initializeForm() {
    _nameController.text = widget.customer['name'] ?? '';
    _phoneController.text = widget.customer['phone'] ?? '';
    _emailController.text = widget.customer['email'] ?? '';
    _addressController.text = widget.customer['address'] ?? '';
    _notesController.text = widget.customer['notes'] ?? '';
    _customerType = widget.customer['type'] ?? 'Regular';
    _customerStatus = widget.customer['status'] ?? 'active';
  }


  void _resetForm() {
    _initializeForm();
    setState(() {});
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text('Delete Customer'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete ${widget.customer['name']}?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('This action cannot be undone. All customer data including order history will be permanently deleted.'),
            if (widget.customer['totalOrders'] > 0) ...[
              const SizedBox(height: 12),
              Text(
                '⚠️ This customer has ${widget.customer['totalOrders']} orders and has spent \$${widget.customer['totalSpent']}.',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close confirmation dialog
              _deleteCustomer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete Customer'),
          ),
        ],
      ),
    );
  }

  void _deleteCustomer() {
    // Here you would typically delete the customer from your database
    print('Deleting customer: ${widget.customer['id']}');

    // Show deletion in progress
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleting customer...'),
        backgroundColor: Colors.orange,
      ),
    );

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, 'deleted'); // Return to customer list with deletion signal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.customer['name']} has been deleted'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _showQuickStats() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.DarkBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatItem('Total Orders', widget.customer['totalOrders'].toString()),
            _buildStatItem('Total Amount Spent', '\$${widget.customer['totalSpent']}'),
            _buildStatItem('Current Balance', '\$${widget.customer['currentBalance']}'),
            _buildStatItem('Member Since', widget.customer['joinDate']),
            _buildStatItem('Last Order', widget.customer['lastOrderDate'] ?? 'No orders yet'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.DarkBlue,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit ${widget.customer['name']}',
          style: const TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics, color: AppColors.primaryBlue),
            onPressed: _showQuickStats,
            tooltip: 'View Statistics',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Avatar and Quick Info
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.DarkBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Customer since ${widget.customer['joinDate']}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: widget.customer['status'] == 'active' ? Colors.green : Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.customer['status'] == 'active' ? 'Active' : 'Inactive',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${widget.customer['totalOrders']} orders',
                                    style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Edit Customer Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Update the customer details below',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),

              // Customer Status
              DropdownButtonFormField<String>(
                value: _customerStatus,
                decoration: const InputDecoration(
                  labelText: 'Customer Status *',
                  prefixIcon: Icon(Icons.circle, size: 16),
                  border: OutlineInputBorder(),
                  helperText: 'Active customers can place new orders',
                ),
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status == 'active' ? 'Active' : 'Inactive'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _customerStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Customer Type
              DropdownButtonFormField<String>(
                value: _customerType,
                decoration: const InputDecoration(
                  labelText: 'Customer Type *',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _customerTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _customerType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Customer Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Address
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address *',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter delivery address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Additional Notes
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  helperText: 'Any special instructions or notes about this customer',
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: RoundedButton(
                      text: 'Reset Changes',
                      onPressed: _resetForm,
                      backgroundColor: Colors.grey.shade300,
                      textColor: AppColors.DarkBlue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RoundedButton(
                      text: 'Update Customer',
                      onPressed: (){},
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}