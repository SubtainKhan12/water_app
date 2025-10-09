// lib/views/products/add_product_screen.dart
import 'package:flutter/material.dart';
import '../../../res/colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _minStockController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();

  String _selectedCategory = 'Beverages';
  bool _isFeatured = false;
  bool _isActive = true;

  final List<String> _categories = ['Beverages', 'Containers', 'Equipment', 'Filters', 'Accessories'];
  final List<String> _units = ['bottle', 'jug', 'unit', 'system', 'cartridge', 'piece'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    _unitController.dispose();
    _barcodeController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Save product logic here
      final newProduct = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'price': double.parse(_priceController.text),
        'costPrice': double.parse(_costPriceController.text),
        'stock': int.parse(_stockController.text),
        'minStock': int.parse(_minStockController.text),
        'unit': _unitController.text,
        'barcode': _barcodeController.text,
        'supplier': _supplierController.text,
        'image': 'assets/products/default.jpg',
        'status': _isActive ? 'active' : 'inactive',
        'createdAt': DateTime.now().toIso8601String().split('T')[0],
        'isFeatured': _isFeatured,
      };

      // Here you would typically save to your database
      print('New Product: $newProduct');

      // Return to previous screen with success
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Product added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _generateBarcode() {
    // Simple barcode generator - in real app, this would be more sophisticated
    final randomBarcode = '1${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 12)}';
    setState(() {
      _barcodeController.text = randomBarcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: AppColors.primaryBlue),
            onPressed: _saveProduct,
            tooltip: 'Save Product',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              _buildTextFormField(
                controller: _nameController,
                label: 'Product Name *',
                hintText: 'Enter product name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _descriptionController,
                label: 'Description *',
                hintText: 'Enter product description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),

              // Category and Unit Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownFormField(
                      value: _selectedCategory,
                      items: _categories,
                      label: 'Category *',
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownFormField(
                      value: _units.first,
                      items: _units,
                      label: 'Unit *',
                      onChanged: (value) {
                        setState(() {
                          _unitController.text = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Pricing Section
              _buildSectionHeader('Pricing'),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _priceController,
                      label: 'Selling Price *',
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.attach_money,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter selling price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid price';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _costPriceController,
                      label: 'Cost Price *',
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.money_off,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter cost price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid cost';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // Inventory Section
              _buildSectionHeader('Inventory'),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _stockController,
                      label: 'Current Stock *',
                      hintText: '0',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter stock quantity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _minStockController,
                      label: 'Minimum Stock *',
                      hintText: '0',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter minimum stock';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // Supplier & Barcode Section
              _buildSectionHeader('Supplier & Identification'),
              _buildTextFormField(
                controller: _supplierController,
                label: 'Supplier *',
                hintText: 'Enter supplier name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter supplier name';
                  }
                  return null;
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _barcodeController,
                      label: 'Barcode',
                      hintText: 'Enter barcode or generate',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: ElevatedButton.icon(
                      onPressed: _generateBarcode,
                      icon: const Icon(Icons.qr_code, size: 18),
                      label: const Text('Generate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightSkyBlue,
                        foregroundColor: AppColors.DarkBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),

              // Status & Features Section
              _buildSectionHeader('Status & Features'),
              _buildSwitchOption(
                title: 'Active Product',
                subtitle: 'Product will be available for sales',
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              _buildSwitchOption(
                title: 'Featured Product',
                subtitle: 'Show this product as featured',
                value: _isFeatured,
                onChanged: (value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),

              // Save Button
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Product',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.DarkBlue,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.DarkBlue,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String value,
    required List<String> items,
    required String label,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.DarkBlue,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: AppColors.DarkBlue,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.DarkBlue,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}