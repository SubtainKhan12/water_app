// views/delivery_management/edit_delivery_zone.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class EditDeliveryZoneScreen extends StatefulWidget {
  final Map<String, dynamic> zone;

  const EditDeliveryZoneScreen({super.key, required this.zone});

  @override
  State<EditDeliveryZoneScreen> createState() => _EditDeliveryZoneScreenState();
}

class _EditDeliveryZoneScreenState extends State<EditDeliveryZoneScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _areaController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _deliveryChargeController;
  late TextEditingController _activeStaffController;
  late TextEditingController _totalOrdersController;
  late TextEditingController _areaInputController;

  late String _selectedStatus;
  late Color _selectedColor;
  late List<String> _areas;

  final List<Color> _availableColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.zone['name']);
    _areaController = TextEditingController(text: widget.zone['area']);
    _deliveryTimeController = TextEditingController(text: widget.zone['deliveryTime']);

    // Remove 'PKR ' prefix from delivery charge
    final deliveryCharge = widget.zone['deliveryCharge'].toString().replaceAll('PKR ', '');
    _deliveryChargeController = TextEditingController(text: deliveryCharge);

    _activeStaffController = TextEditingController(text: widget.zone['activeStaff'].toString());
    _totalOrdersController = TextEditingController(text: widget.zone['totalOrders'].toString());
    _areaInputController = TextEditingController();

    _selectedStatus = widget.zone['status'];
    _selectedColor = widget.zone['color'];
    _areas = List<String>.from(widget.zone['areas']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _deliveryTimeController.dispose();
    _deliveryChargeController.dispose();
    _activeStaffController.dispose();
    _totalOrdersController.dispose();
    _areaInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit ${widget.zone['name']}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _updateZone,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildNameField(),
              const SizedBox(height: 16),
              _buildAreaField(),
              const SizedBox(height: 16),
              _buildDeliveryTimeField(),
              const SizedBox(height: 16),
              _buildDeliveryChargeField(),
              const SizedBox(height: 16),
              _buildActiveStaffField(),
              const SizedBox(height: 16),
              _buildTotalOrdersField(),
              const SizedBox(height: 16),
              _buildStatusDropdown(),
              const SizedBox(height: 16),
              _buildColorSelection(),
              const SizedBox(height: 16),
              _buildAreasManagement(),
              const SizedBox(height: 32),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Zone Name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.location_on),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter zone name';
        }
        return null;
      },
    );
  }

  Widget _buildAreaField() {
    return TextFormField(
      controller: _areaController,
      decoration: const InputDecoration(
        labelText: 'Area Coverage',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.area_chart),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter area coverage';
        }
        return null;
      },
    );
  }

  Widget _buildDeliveryTimeField() {
    return TextFormField(
      controller: _deliveryTimeController,
      decoration: const InputDecoration(
        labelText: 'Delivery Time',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.access_time),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter delivery time';
        }
        return null;
      },
    );
  }

  Widget _buildDeliveryChargeField() {
    return TextFormField(
      controller: _deliveryChargeController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Delivery Charge (PKR)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter delivery charge';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildActiveStaffField() {
    return TextFormField(
      controller: _activeStaffController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Active Staff Count',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.people),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter staff count';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter valid number';
        }
        return null;
      },
    );
  }

  Widget _buildTotalOrdersField() {
    return TextFormField(
      controller: _totalOrdersController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Total Orders Today',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.local_shipping),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter orders count';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter valid number';
        }
        return null;
      },
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.DarkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedStatus,
            items: ['Active', 'Inactive'].map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(
                  status,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedStatus = newValue!;
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Zone Color',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.DarkBlue,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableColors.length,
            itemBuilder: (context, index) {
              final color = _availableColors[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: _selectedColor == color
                        ? Border.all(color: Colors.black, width: 3)
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAreasManagement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Covered Areas',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.DarkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _areaInputController,
                decoration: const InputDecoration(
                  labelText: 'Add Area',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Gulberg III',
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _addArea,
              icon: const Icon(Icons.add, color: AppColors.primaryBlue),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildAreasList(),
      ],
    );
  }

  Widget _buildAreasList() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: _areas.map((area) {
        return Chip(
          label: Text(
            area,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: AppColors.skyBlue.withOpacity(0.2),
          deleteIcon: const Icon(Icons.close, size: 16),
          onDeleted: () => _removeArea(area),
        );
      }).toList(),
    );
  }

  Widget _buildUpdateButton() {
    return ElevatedButton(
      onPressed: _updateZone,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Update Delivery Zone',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _addArea() {
    final area = _areaInputController.text.trim();
    if (area.isNotEmpty && !_areas.contains(area)) {
      setState(() {
        _areas.add(area);
        _areaInputController.clear();
      });
    }
  }

  void _removeArea(String area) {
    setState(() {
      _areas.remove(area);
    });
  }

  void _updateZone() {
    if (_formKey.currentState!.validate()) {
      if (_areas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one covered area'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Update zone logic here
      final updatedZone = {
        ...widget.zone,
        'name': _nameController.text,
        'area': _areaController.text,
        'deliveryTime': _deliveryTimeController.text,
        'deliveryCharge': 'PKR ${_deliveryChargeController.text}',
        'activeStaff': int.parse(_activeStaffController.text),
        'totalOrders': int.parse(_totalOrdersController.text),
        'status': _selectedStatus,
        'color': _selectedColor,
        'areas': List<String>.from(_areas),
      };

      // Here you would typically update your data source
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delivery zone updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, updatedZone);
    }
  }
}