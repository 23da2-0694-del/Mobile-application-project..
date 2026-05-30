import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class AddEditAddressScreen extends StatefulWidget {
  final Map<String, dynamic>? address;

  const AddEditAddressScreen({super.key, this.address});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  
  String _selectedCountry = 'United States';
  bool _isDefault = false;
  bool _isLoading = false;

  final List<String> _countries = [
    'United States',
    'Sri Lanka',
    'India',
    'United Kingdom',
    'Australia',
    'Canada',
  ];

  bool get isEditMode => widget.address != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      final addr = widget.address!;
      _titleCtrl.text = addr['title'] ?? '';
      _firstNameCtrl.text = addr['firstName'] ?? '';
      _lastNameCtrl.text = addr['lastName'] ?? '';
      _streetCtrl.text = addr['street'] ?? '';
      _cityCtrl.text = addr['city'] ?? '';
      _postalCtrl.text = addr['postalCode'] ?? '';
      _phoneCtrl.text = addr['phone'] ?? '';
      
      final countryVal = addr['country'] ?? 'United States';
      if (_countries.contains(countryVal)) {
        _selectedCountry = countryVal;
      } else {
        _selectedCountry = _countries.first;
      }
      _isDefault = addr['isDefault'] ?? false;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _postalCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final addressData = {
          'title': _titleCtrl.text.trim(),
          'firstName': _firstNameCtrl.text.trim(),
          'lastName': _lastNameCtrl.text.trim(),
          'street': _streetCtrl.text.trim(),
          'city': _cityCtrl.text.trim(),
          'postalCode': _postalCtrl.text.trim(),
          'country': _selectedCountry,
          'phone': _phoneCtrl.text.trim(),
          'isDefault': _isDefault,
        };

        final provider = context.read<UserProvider>();
        if (isEditMode) {
          await provider.updateAddress(widget.address!['id'], addressData);
        } else {
          await provider.addAddress(addressData);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditMode ? 'Address updated successfully!' : 'Address added successfully!',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
              ),
              backgroundColor: AppTheme.successColor,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save address: $e'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Widget _buildChip(String title) {
    final isSelected = _titleCtrl.text.toLowerCase() == title.toLowerCase();
    return GestureDetector(
      onTap: () {
        setState(() {
          _titleCtrl.text = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryDark : AppTheme.dividerColor,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.white : AppTheme.textDark,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Address' : 'Add New Address'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title / Tag Selection
              Text(
                'Address Title (e.g. Home, Office)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  hintText: 'Enter address label',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildChip('Home'),
                  const SizedBox(width: 8),
                  _buildChip('Office'),
                  const SizedBox(width: 8),
                  _buildChip('Other'),
                ],
              ),
              const SizedBox(height: 20),
              
              const Divider(color: AppTheme.dividerColor),
              const SizedBox(height: 14),

              Text(
                'Contact Details',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameCtrl,
                      decoration: const InputDecoration(labelText: 'First Name'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameCtrl,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+1 234 567 8900',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              const Divider(color: AppTheme.dividerColor),
              const SizedBox(height: 14),

              Text(
                'Address Details',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _streetCtrl,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  hintText: '123 Fashion Street',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityCtrl,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _postalCtrl,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Postal Code'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                initialValue: _selectedCountry,
                decoration: const InputDecoration(labelText: 'Country'),
                items: _countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCountry = v!),
              ),
              const SizedBox(height: 20),

              const Divider(color: AppTheme.dividerColor),
              const SizedBox(height: 14),

              // Default Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set as Default Address',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        'Use this address as prefill in checkout.',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: _isDefault,
                    activeTrackColor: AppTheme.primaryDark,
                    onChanged: (val) {
                      setState(() {
                        _isDefault = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isLoading ? null : _saveAddress,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('SAVE ADDRESS'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
