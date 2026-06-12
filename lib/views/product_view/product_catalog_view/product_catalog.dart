// lib/views/products/product_catalog_screen.dart
import 'package:flutter/material.dart';
import '../../../res/colors.dart';
import 'add_product.dart';
import 'edit_product.dart';

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedSort = 'Name A-Z';

  final List<String> _categories = [
    'All',
    'Beverages',
    'Containers',
    'Equipment',
    'Filters',
    'Accessories',
  ];
  final List<String> _sortOptions = [
    'Name A-Z',
    'Name Z-A',
    'Price: Low to High',
    'Price: High to Low',
    'Stock: Low to High',
  ];

  // Sample products data
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Mineral Water 1L',
      'description': 'Pure mineral water in 1L bottles',
      'category': 'Beverages',
      'price': 5.00,
      'costPrice': 2.50,
      'stock': 50,
      'minStock': 20,
      'unit': 'bottle',
      'barcode': '1234567890123',
      'supplier': 'Aqua Pure Ltd.',
      'image': 'assets/products/water-1l.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': true,
    },
    {
      'id': '2',
      'name': '5 Gallon Water Jug',
      'description': 'Large 5 gallon water container',
      'category': 'Containers',
      'price': 15.00,
      'costPrice': 8.00,
      'stock': 30,
      'minStock': 15,
      'unit': 'jug',
      'barcode': '1234567890124',
      'supplier': 'Container Corp',
      'image': 'assets/products/5g-jug.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': false,
    },
    {
      'id': '3',
      'name': 'Water Dispenser',
      'description': 'Premium water dispenser with hot and cold options',
      'category': 'Equipment',
      'price': 80.00,
      'costPrice': 45.00,
      'stock': 15,
      'minStock': 10,
      'unit': 'unit',
      'barcode': '1234567890125',
      'supplier': 'Dispenser Tech',
      'image': 'assets/products/dispenser.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': true,
    },
    {
      'id': '4',
      'name': 'Glass Water Bottle',
      'description': 'Eco-friendly glass water bottle',
      'category': 'Containers',
      'price': 12.00,
      'costPrice': 6.00,
      'stock': 25,
      'minStock': 10,
      'unit': 'bottle',
      'barcode': '1234567890126',
      'supplier': 'Eco Bottles',
      'image': 'assets/products/glass-bottle.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': false,
    },
    {
      'id': '5',
      'name': 'Water Filter System',
      'description': 'Advanced water filtration system',
      'category': 'Filters',
      'price': 45.00,
      'costPrice': 25.00,
      'stock': 20,
      'minStock': 5,
      'unit': 'system',
      'barcode': '1234567890127',
      'supplier': 'Filter Masters',
      'image': 'assets/products/filter-system.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': true,
    },
    {
      'id': '6',
      'name': 'Water Filter Cartridge',
      'description': 'Replacement filter cartridge',
      'category': 'Filters',
      'price': 8.00,
      'costPrice': 4.00,
      'stock': 5,
      'minStock': 10,
      'unit': 'cartridge',
      'barcode': '1234567890128',
      'supplier': 'Filter Masters',
      'image': 'assets/products/filter-cartridge.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': false,
    },
    {
      'id': '7',
      'name': 'Bottle Cap',
      'description': 'Replacement bottle caps',
      'category': 'Accessories',
      'price': 0.50,
      'costPrice': 0.10,
      'stock': 200,
      'minStock': 50,
      'unit': 'piece',
      'barcode': '1234567890129',
      'supplier': 'Plastic Parts Inc.',
      'image': 'assets/products/bottle-cap.jpg',
      'status': 'active',
      'createdAt': '2024-01-01',
      'isFeatured': false,
    },
    {
      'id': '8',
      'name': 'Mineral Water 500ml',
      'description': 'Pure mineral water in 500ml bottles',
      'category': 'Beverages',
      'price': 3.00,
      'costPrice': 1.50,
      'stock': 0,
      'minStock': 25,
      'unit': 'bottle',
      'barcode': '1234567890130',
      'supplier': 'Aqua Pure Ltd.',
      'image': 'assets/products/water-500ml.jpg',
      'status': 'inactive',
      'createdAt': '2024-01-01',
      'isFeatured': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = _products;

    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered.where((product) {
        return product['category'] == _selectedCategory;
      }).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final query = _searchQuery.toLowerCase();
        return product['name'].toLowerCase().contains(query) ||
            product['description'].toLowerCase().contains(query) ||
            product['barcode'].contains(query) ||
            product['supplier'].toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Name A-Z':
          return a['name'].compareTo(b['name']);
        case 'Name Z-A':
          return b['name'].compareTo(a['name']);
        case 'Price: Low to High':
          return a['price'].compareTo(b['price']);
        case 'Price: High to Low':
          return b['price'].compareTo(a['price']);
        case 'Stock: Low to High':
          return a['stock'].compareTo(b['stock']);
        default:
          return 0;
      }
    });

    return filtered;
  }

  int get _lowStockCount {
    return _products
        .where((product) => product['stock'] <= product['minStock'])
        .length;
  }

  int get _outOfStockCount {
    return _products.where((product) => product['stock'] == 0).length;
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _openAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    ).then((value) {
      if (value != null && value == true) {
        setState(() {}); // Refresh product list
      }
    });
  }

  void _openEditProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product),
      ),
    ).then((value) {
      if (value != null && value == true) {
        setState(() {}); // Refresh product list
      }
    });
  }

  void _showProductDetails(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildProductDetailsSheet(product),
    );
  }

  void _updateStock(String productId, int newStock) {
    setState(() {
      final productIndex = _products.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _products[productIndex]['stock'] = newStock;
      }
    });
  }

  void _toggleProductStatus(String productId) {
    setState(() {
      final productIndex = _products.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _products[productIndex]['status'] =
            _products[productIndex]['status'] == 'active'
            ? 'inactive'
            : 'active';
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Product Catalog',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primaryBlue),
            onPressed: _openAddProduct,
            tooltip: 'Add New Product',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          _buildSearchFilters(),

          // Quick Stats
          _buildQuickStats(),

          // Products Grid/List
          Expanded(child: _buildProductsView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProduct,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: _performSearch,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Filters Row
          Row(
            children: [
              // Category Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightSkyBlue),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: AppColors.DarkBlue,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Sort Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightSkyBlue),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedSort,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _sortOptions.map((String sort) {
                      return DropdownMenuItem<String>(
                        value: sort,
                        child: Text(
                          sort,
                          style: const TextStyle(
                            color: AppColors.DarkBlue,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSort = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          _buildStatItem(
            'Total Products',
            _products.length.toString(),
            Icons.inventory,
          ),
          const SizedBox(width: 16),
          _buildStatItem(
            'Low Stock',
            _lowStockCount.toString(),
            Icons.warning,
            color: Colors.orange,
          ),
          const SizedBox(width: 16),
          _buildStatItem(
            'Out of Stock',
            _outOfStockCount.toString(),
            Icons.error,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon, {
    Color color = AppColors.primaryBlue,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsView() {
    if (_filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isNotEmpty
                  ? Icons.search_off
                  : Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No products found for "$_searchQuery"'
                  : 'No products available',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            if (_searchQuery.isEmpty)
              TextButton(
                onPressed: _openAddProduct,
                child: const Text(
                  'Add First Product',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isOutOfStock = product['stock'] == 0;
    final isLowStock =
        product['stock'] <= product['minStock'] && product['stock'] > 0;
    final isInactive = product['status'] == 'inactive';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showProductDetails(product),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: isInactive ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isInactive ? Border.all(color: Colors.grey.shade300) : null,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image/Icon
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getProductIcon(product['category']),
                        size: 40,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),

                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name and Status
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isInactive
                                      ? Colors.grey
                                      : AppColors.DarkBlue,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (product['isFeatured'])
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Category
                        Text(
                          product['category'],
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.skyBlue,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Price and Stock
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isInactive
                                    ? Colors.grey
                                    : AppColors.primaryBlue,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${product['stock']} ${product['unit']}',
                              style: TextStyle(
                                color: isOutOfStock
                                    ? Colors.red
                                    : isLowStock
                                    ? Colors.orange
                                    : Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Status Badges
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: [
                    if (isOutOfStock)
                      _buildStatusBadge('Out of Stock', Colors.red),
                    if (isLowStock && !isOutOfStock)
                      _buildStatusBadge('Low Stock', Colors.orange),
                    if (isInactive) _buildStatusBadge('Inactive', Colors.grey),
                  ],
                ),
              ),

              // Action Menu
              Positioned(
                top: 5,
                right: 0,
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Colors.grey,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _openEditProduct(product);
                    } else if (value == 'toggle_status') {
                      _toggleProductStatus(product['id']);
                    } else if (value == 'update_stock') {
                      _showUpdateStockDialog(product);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit Product'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'toggle_status',
                      child: Row(
                        children: [
                          Icon(
                            product['status'] == 'active'
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product['status'] == 'active'
                                ? 'Deactivate'
                                : 'Activate',
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'update_stock',
                      child: Row(
                        children: [
                          Icon(Icons.inventory, size: 16),
                          SizedBox(width: 8),
                          Text('Update Stock'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
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

  void _showUpdateStockDialog(Map<String, dynamic> product) {
    final stockController = TextEditingController(
      text: product['stock'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Stock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${product['name']}'),
            const SizedBox(height: 8),
            Text('Current Stock: ${product['stock']} ${product['unit']}'),
            const SizedBox(height: 16),
            TextFormField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'New Stock Quantity',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newStock =
                  int.tryParse(stockController.text) ?? product['stock'];
              _updateStock(product['id'], newStock);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Stock updated to $newStock ${product['unit']}',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Update Stock'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailsSheet(Map<String, dynamic> product) {
    final isOutOfStock = product['stock'] == 0;
    final isLowStock =
        product['stock'] <= product['minStock'] && product['stock'] > 0;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getProductIcon(product['category']),
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
                      product['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.DarkBlue,
                      ),
                    ),
                    Text(
                      product['category'],
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              if (product['isFeatured'])
                const Icon(Icons.star, color: Colors.amber, size: 24),
            ],
          ),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Stats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDetailStat('Price', '\$${product['price']}'),
                        _buildDetailStat('Cost', '\$${product['costPrice']}'),
                        _buildDetailStat('Stock', '${product['stock']}'),
                        _buildDetailStat('Min Stock', '${product['minStock']}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Product Information
                  const Text(
                    'Product Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.DarkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailItem('Description', product['description']),
                  _buildDetailItem('Barcode', product['barcode']),
                  _buildDetailItem('Supplier', product['supplier']),
                  _buildDetailItem('Unit', product['unit']),
                  _buildDetailItem(
                    'Status',
                    product['status'] == 'active' ? 'Active' : 'Inactive',
                  ),
                  _buildDetailItem('Created', product['createdAt']),

                  // Stock Alert
                  if (isOutOfStock || isLowStock) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isOutOfStock
                            ? Colors.red.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isOutOfStock ? Colors.red : Colors.orange,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isOutOfStock ? Icons.error : Icons.warning,
                            color: isOutOfStock ? Colors.red : Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isOutOfStock
                                  ? 'This product is out of stock. Consider restocking soon.'
                                  : 'This product is running low on stock. Minimum stock level is ${product['minStock']}.',
                              style: TextStyle(
                                color: isOutOfStock
                                    ? Colors.red
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
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
                  child: const Text('Close'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openEditProduct(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Edit Product'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.DarkBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
