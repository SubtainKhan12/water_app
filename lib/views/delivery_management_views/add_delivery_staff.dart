// views/delivery_management/add_delivery_staff.dart
import 'package:flutter/material.dart';
import 'package:water_app/res/colors.dart';

class AddDeliveryStaffScreen extends StatefulWidget {
  const AddDeliveryStaffScreen({super.key});

  @override
  State<AddDeliveryStaffScreen> createState() => _AddDeliveryStaffScreenState();
}

class _AddDeliveryStaffScreenState extends State<AddDeliveryStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectedZone = 'Gulberg, Lahore';
  String _selectedVehicleType = 'Motorcycle';
  DateTime _selectedDate = DateTime.now();

  final List<String> _zones = [
    'Gulberg, Lahore',
    'DHA, Lahore',
    'Model Town, Lahore',
    'DHA, Karachi',
    'Clifton, Karachi',
    'F-7, Islamabad',
    'F-8, Islamabad',
    'Saddar, Rawalpindi',
    'Bahria Town, Rawalpindi',
    'University Road, Peshawar'
  ];

  final List<String> _vehicleTypes = [
    'Motorcycle',
    'Car',
    'Van',
    'Rickshaw'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Delivery Staff',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _saveStaff,
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
              _buildPhoneField(),
              const SizedBox(height: 16),
              _buildCnicField(),
              const SizedBox(height: 16),
              _buildVehicleTypeDropdown(),
              const SizedBox(height: 16),
              _buildVehicleNumberField(),
              const SizedBox(height: 16),
              _buildZoneDropdown(),
              const SizedBox(height: 16),
              _buildAddressField(),
              const SizedBox(height: 16),
              _buildJoinDatePicker(),
              const SizedBox(height: 32),
              _buildSaveButton(),
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
        labelText: 'Full Name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter staff name';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
        prefixText: '+92 ',
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        if (value.length < 10) {
          return 'Please enter valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildCnicField() {
    return TextFormField(
      controller: _cnicController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'CNIC Number',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.credit_card),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
        hintText: '12345-6789012-3',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter CNIC number';
        }
        return null;
      },
    );
  }

  Widget _buildVehicleTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vehicle Type',
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
            initialValue: _selectedVehicleType,
            items: _vehicleTypes.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedVehicleType = newValue!;
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

  Widget _buildVehicleNumberField() {
    return TextFormField(
      controller: _vehicleController,
      decoration: const InputDecoration(
        labelText: 'Vehicle Number',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.directions_bike),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
        hintText: 'LEA 1234',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter vehicle number';
        }
        return null;
      },
    );
  }

  Widget _buildZoneDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Zone',
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
            value: _selectedZone,
            items: _zones.map((String zone) {
              return DropdownMenuItem<String>(
                value: zone,
                child: Text(
                  zone,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedZone = newValue!;
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

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      maxLines: 2,
      decoration: const InputDecoration(
        labelText: 'Home Address',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.home),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter home address';
        }
        return null;
      },
    );
  }

  Widget _buildJoinDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Join Date',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.DarkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: const Icon(Icons.calendar_today, color: AppColors.primaryBlue),
            title: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () => _selectDate(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveStaff,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Save Delivery Staff',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveStaff() {
    if (_formKey.currentState!.validate()) {
      // Save delivery staff logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delivery staff added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}