// lib/views/customers/add_customer_screen.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/widgets/round_button.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _customerType = 'Regular';
  final List<String> _customerTypes = ['Regular', 'Premium', 'Corporate'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the customer to your database
      final customerData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'address': _addressController.text,
        'type': _customerType,
        'notes': _notesController.text,
        'joinDate': DateTime.now().toIso8601String(),
      };

      print('New Customer: $customerData');

      // Show success message and return to previous screen
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Customer Added'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_nameController.text}'),
            Text('Phone: ${_phoneController.text}'),
            Text('Type: $_customerType'),
            const SizedBox(height: 16),
            const Text('Customer has been successfully added to the system.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, true); // Return to customer list with refresh
            },
            child: const Text('View Customers'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _clearForm();
            },
            child: const Text('Add Another'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _addressController.clear();
    _notesController.clear();
    setState(() {
      _customerType = 'Regular';
    });
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Customer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.DarkBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in the customer details below',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            // Customer Type
            DropdownButtonFormField<String>(
              value: _customerType,
              decoration: const InputDecoration(
                labelText: 'Customer Type',
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
                labelText: 'Additional Notes (Optional)',
                prefixIcon: Icon(Icons.note),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    text: 'Clear Form',
                    onPressed: _clearForm,
                    backgroundColor: Colors.grey.shade300,
                    textColor: AppColors.DarkBlue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RoundedButton(
                    text: 'Add Customer',
                    onPressed: _submitForm,
                    backgroundColor: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}