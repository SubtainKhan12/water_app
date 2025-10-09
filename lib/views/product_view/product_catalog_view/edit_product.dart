// lib/views/products/edit_product_screen.dart
import 'package:flutter/material.dart';
import '../../../res/colors.dart';

class EditProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _costPriceController;
  late TextEditingController _stockController;
  late TextEditingController _minStockController;
  late TextEditingController _unitController;
  late TextEditingController _barcodeController;
  late TextEditingController _supplierController;

  late String _selectedCategory;
  late String _selectedUnits;
  late bool _isFeatured;
  late bool _isActive;

  final List<String> _categories = ['Beverages', 'Containers', 'Equipment', 'Filters', 'Accessories'];
  final List<String> _units = ['bottle', 'jug', 'unit', 'system', 'cartridge', 'piece'];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.product['name']);
    _descriptionController = TextEditingController(text: widget.product['description']);
    _priceController = TextEditingController(text: widget.product['price'].toString());
    _costPriceController = TextEditingController(text: widget.product['costPrice'].toString());
    _stockController = TextEditingController(text: widget.product['stock'].toString());
    _minStockController = TextEditingController(text: widget.product['minStock'].toString());
    _unitController = TextEditingController(text: widget.product['unit']);
    _barcodeController = TextEditingController(text: widget.product['barcode']);
    _supplierController = TextEditingController(text: widget.product['supplier']);

    _selectedCategory = widget.product['category'];
    _selectedUnits = widget.product['unit'];
    _isFeatured = widget.product['isFeatured'] ?? false;
    _isActive = widget.product['status'] == 'active';
  }

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

  void _updateProduct() {
    if (_formKey.currentState!.validate()) {
      // Update product logic here
      final updatedProduct = {
        ...widget.product,
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
        'status': _isActive ? 'active' : 'inactive',
        'isFeatured': _isFeatured,
      };

      // Here you would typically update in your database
      print('Updated Product: $updatedProduct');

      // Return to previous screen with success
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Product updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${widget.product['name']}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _deleteProduct();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteProduct() {
    // Delete product logic here
    print('Deleting product: ${widget.product['id']}');

    Navigator.pop(context, true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Product deleted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Product',
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
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: _showDeleteDialog,
            tooltip: 'Delete Product',
          ),
          IconButton(
            icon: const Icon(Icons.save, color: AppColors.primaryBlue),
            onPressed: _updateProduct,
            tooltip: 'Save Changes',
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
              // Product Header with Image
              _buildProductHeader(),

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
                      value: _selectedUnits,
                      items: _units,
                      label: 'Category *',
                      onChanged: (value) {
                        setState(() {
                          _selectedUnits = value!;
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

              _buildTextFormField(
                controller: _barcodeController,
                label: 'Barcode',
                hintText: 'Enter barcode',
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

              // Action Buttons
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _updateProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getProductIcon(widget.product['category']),
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
                  widget.product['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${widget.product['id']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Created: ${widget.product['createdAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (widget.product['isFeatured'])
            const Icon(Icons.star, color: Colors.amber, size: 24),
        ],
      ),
    );
  }

  IconData _getProductIcon(String category) {
    switch (category) {
      case 'Beverages':
        return Icons.local_drink;
      case 'Containers':
        return Icons.water_drop;
      case 'Equipment':
        return Icons.kitchen;
      case 'Filters':
        return Icons.filter_alt;
      case 'Accessories':
        return Icons.construction;
      default:
        return Icons.inventory_2;
    }
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