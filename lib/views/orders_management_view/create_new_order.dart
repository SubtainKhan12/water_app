// lib/views/orders/create_order_screen.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/widgets/round_button.dart';

class CreateNewOrderScreen extends StatefulWidget {
  const CreateNewOrderScreen({super.key});

  @override
  State<CreateNewOrderScreen> createState() => _CreateNewOrderScreenState();
}

class _CreateNewOrderScreenState extends State<CreateNewOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController = TextEditingController();
  final TextEditingController _customerAddressController = TextEditingController();
  final TextEditingController _specialInstructionsController = TextEditingController();

  // Sample products data
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Mineral Water 1L',
      'price': 5.00,
      'stock': 50,
      'category': 'Beverages',
    },
    {
      'id': '2',
      'name': '5 Gallon Water Jug',
      'price': 15.00,
      'stock': 30,
      'category': 'Containers',
    },
    {
      'id': '3',
      'name': 'Water Dispenser',
      'price': 80.00,
      'stock': 15,
      'category': 'Equipment',
    },
    {
      'id': '4',
      'name': 'Glass Water Bottle',
      'price': 12.00,
      'stock': 25,
      'category': 'Bottles',
    },
    {
      'id': '5',
      'name': 'Water Filter',
      'price': 45.00,
      'stock': 20,
      'category': 'Equipment',
    },
  ];

  // Selected products with quantities
  final List<Map<String, dynamic>> _selectedProducts = [];

  // Form fields
  String _selectedPaymentMethod = 'Cash on Delivery';
  DateTime _selectedDeliveryDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedDeliveryTime = const TimeOfDay(hour: 10, minute: 0);
  String _deliveryAgent = 'Auto Assign';

  final List<String> _paymentMethods = [
    'Cash on Delivery',
    'Credit Card',
    'Digital Wallet',
    'Bank Transfer',
  ];

  final List<String> _deliveryAgents = [
    'Auto Assign',
    'Mike Johnson',
    'Sarah Wilson',
    'David Lee',
    'Emma Davis',
  ];

  double get _totalAmount {
    double total = 0;
    for (var product in _selectedProducts) {
      total += product['price'] * product['quantity'];
    }
    return total;
  }

  void _addProduct(Map<String, dynamic> product) {
    final existingIndex = _selectedProducts.indexWhere((p) => p['id'] == product['id']);

    if (existingIndex != -1) {
      setState(() {
        _selectedProducts[existingIndex]['quantity'] += 1;
      });
    } else {
      setState(() {
        _selectedProducts.add({
          'id': product['id'],
          'name': product['name'],
          'price': product['price'],
          'quantity': 1,
          'stock': product['stock'],
        });
      });
    }
  }

  void _removeProduct(String productId) {
    setState(() {
      _selectedProducts.removeWhere((product) => product['id'] == productId);
    });
  }

  void _updateProductQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      _removeProduct(productId);
      return;
    }

    setState(() {
      final productIndex = _selectedProducts.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _selectedProducts[productIndex]['quantity'] = quantity;
      }
    });
  }

  Future<void> _selectDeliveryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDeliveryDate) {
      setState(() {
        _selectedDeliveryDate = picked;
      });
    }
  }

  Future<void> _selectDeliveryTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedDeliveryTime,
    );
    if (picked != null && picked != _selectedDeliveryTime) {
      setState(() {
        _selectedDeliveryTime = picked;
      });
    }
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate() && _selectedProducts.isNotEmpty) {
      // Here you would typically send the order to your backend
      final orderData = {
        'customerName': _customerNameController.text,
        'customerPhone': _customerPhoneController.text,
        'customerAddress': _customerAddressController.text,
        'products': _selectedProducts,
        'totalAmount': _totalAmount,
        'paymentMethod': _selectedPaymentMethod,
        'deliveryDate': _selectedDeliveryDate,
        'deliveryTime': _selectedDeliveryTime,
        'deliveryAgent': _deliveryAgent,
        'specialInstructions': _specialInstructionsController.text,
        'status': 'pending',
      };

      print('Order Created: $orderData');

      // Show success dialog
      _showSuccessDialog();
    } else if (_selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one product to the order'),
          backgroundColor: Colors.orange,
        ),
      );
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
            Text('Order Created Successfully'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${_customerNameController.text}'),
            Text('Total Amount: \$$_totalAmount'),
            Text('Delivery: ${_formatDate(_selectedDeliveryDate)} at ${_selectedDeliveryTime.format(context)}'),
            const SizedBox(height: 16),
            const Text('The order has been created and is pending confirmation.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to orders list
            },
            child: const Text('View Orders'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _clearForm();
            },
            child: const Text('Create Another'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _customerNameController.clear();
    _customerPhoneController.clear();
    _customerAddressController.clear();
    _specialInstructionsController.clear();
    setState(() {
      _selectedProducts.clear();
      _selectedPaymentMethod = 'Cash on Delivery';
      _selectedDeliveryDate = DateTime.now().add(const Duration(days: 1));
      _selectedDeliveryTime = const TimeOfDay(hour: 10, minute: 0);
      _deliveryAgent = 'Auto Assign';
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerAddressController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Create New Order',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: AppColors.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Information Section
                    _buildSectionHeader('Customer Information', Icons.person),
                    _buildCustomerForm(),

                    const SizedBox(height: 24),

                    // Products Section
                    _buildSectionHeader('Select Products', Icons.inventory),
                    _buildProductsGrid(),

                    const SizedBox(height: 16),

                    // Selected Products
                    if (_selectedProducts.isNotEmpty) _buildSelectedProducts(),

                    const SizedBox(height: 24),

                    // Delivery Information
                    _buildSectionHeader('Delivery Information', Icons.local_shipping),
                    _buildDeliveryForm(),

                    const SizedBox(height: 24),

                    // Payment Method
                    _buildSectionHeader('Payment Method', Icons.payment),
                    _buildPaymentMethod(),

                    const SizedBox(height: 24),

                    // Special Instructions
                    _buildSectionHeader('Special Instructions', Icons.note),
                    _buildSpecialInstructions(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Order Summary & Submit Button
            _buildOrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryBlue, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.DarkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerForm() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          TextFormField(
            controller: _customerNameController,
            decoration: const InputDecoration(
              labelText: 'Customer Name *',
              prefixIcon: Icon(Icons.person_outline),
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
          TextFormField(
            controller: _customerPhoneController,
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
          TextFormField(
            controller: _customerAddressController,
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
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isOutOfStock = product['stock'] <= 0;
    final selectedProduct = _selectedProducts.firstWhere(
          (p) => p['id'] == product['id'],
      orElse: () => {},
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: isOutOfStock ? null : () => _addProduct(product),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isOutOfStock ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: selectedProduct.isNotEmpty
                ? Border.all(color: AppColors.primaryBlue, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isOutOfStock ? Colors.grey : AppColors.DarkBlue,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'],
                    style: TextStyle(
                      color: isOutOfStock ? Colors.grey : AppColors.skyBlue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isOutOfStock ? Colors.grey : AppColors.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock: ${product['stock']}',
                        style: TextStyle(
                          color: isOutOfStock ? Colors.red : Colors.green,
                          fontSize: 10,
                        ),
                      ),
                      if (selectedProduct.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${selectedProduct['quantity']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedProducts() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.DarkBlue,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ..._selectedProducts.map((product) => _buildSelectedProductItem(product)).toList(),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkBlue,
                  ),
                ),
                Text(
                  '\$$_totalAmount',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedProductItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.DarkBlue,
                  ),
                ),
                Text(
                  '\$${product['price']} each',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: () {
                  _updateProductQuantity(product['id'], product['quantity'] - 1);
                },
                color: AppColors.primaryBlue,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.lightSkyBlue),
                ),
                child: Text(
                  '${product['quantity']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkBlue,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () {
                  if (product['quantity'] < product['stock']) {
                    _updateProductQuantity(product['id'], product['quantity'] + 1);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Only ${product['stock']} items available in stock'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => _removeProduct(product['id']),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryForm() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _selectDeliveryDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.lightSkyBlue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery Date',
                          style: TextStyle(
                            color: AppColors.skyBlue,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(_selectedDeliveryDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.DarkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: _selectDeliveryTime,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.lightSkyBlue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery Time',
                          style: TextStyle(
                            color: AppColors.skyBlue,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedDeliveryTime.format(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.DarkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _deliveryAgent,
            decoration: const InputDecoration(
              labelText: 'Delivery Agent',
              prefixIcon: Icon(Icons.person_pin),
              border: OutlineInputBorder(),
            ),
            items: _deliveryAgents.map((String agent) {
              return DropdownMenuItem<String>(
                value: agent,
                child: Text(agent),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _deliveryAgent = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: DropdownButtonFormField<String>(
        value: _selectedPaymentMethod,
        decoration: const InputDecoration(
          labelText: 'Payment Method',
          prefixIcon: Icon(Icons.payment),
          border: OutlineInputBorder(),
        ),
        items: _paymentMethods.map((String method) {
          return DropdownMenuItem<String>(
            value: method,
            child: Text(method),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: TextFormField(
        controller: _specialInstructionsController,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Special Instructions (Optional)',
          prefixIcon: Icon(Icons.note_add),
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkBlue,
                ),
              ),
              Text(
                '\$$_totalAmount',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RoundedButton(
            text: 'Create Order',
            onPressed: _submitOrder,
            backgroundColor: AppColors.primaryBlue,
            height: 50,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}