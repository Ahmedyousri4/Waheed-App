import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/features/checkout/models/address_model.dart';
import 'package:waheed/features/checkout/widgets/address_text_field.dart';

/// Add new delivery address screen.
///
/// Returns the formatted address string via Navigator.pop when saved,
/// so the Checkout screen can immediately display it.
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  Map<String, String?> _errors = {};
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // ── Validation ─────────────────────────────────────────────────────
  bool _validate() {
    final errors = <String, String?>{};

    if (_nameController.text.trim().isEmpty) {
      errors['name'] = 'يرجى إدخال الاسم الكامل';
    }
    if (_cityController.text.trim().isEmpty) {
      errors['city'] = 'يرجى إدخال المدينة';
    }
    if (_areaController.text.trim().isEmpty) {
      errors['area'] = 'يرجى إدخال المنطقة';
    }
    if (_phoneController.text.trim().isEmpty) {
      errors['phone'] = 'يرجى إدخال رقم الهاتف';
    } else if (_phoneController.text.trim().length < 10) {
      errors['phone'] = 'رقم الهاتف غير صحيح';
    }
    if (_addressController.text.trim().isEmpty) {
      errors['address'] = 'يرجى إدخال العنوان بالتفصيل';
    }

    setState(() => _errors = errors);
    return errors.isEmpty;
  }

  void _onSave() {
    if (!_validate()) return;

    setState(() => _isSubmitting = true);

    // Build AddressModel to return to Checkout.
    final addressModel = AddressModel(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      city: _cityController.text.trim(),
      area: _areaController.text.trim(),
      detailedAddress: _addressController.text.trim(),
    );

    // TODO: Connect to address API/repository when available.
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pop(context, addressModel);
    });
  }

  // ── Build ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── الاسم الكامل ──
                  AddressTextField(
                    label: 'الاسم الكامل',
                    hint: 'أدخل اسمك الكامل',
                    iconAsset: 'profile.svg',
                    controller: _nameController,
                    errorText: _errors['name'],
                  ),
                  const SizedBox(height: 18),

                  // ── المدينة + المنطقة ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AddressTextField(
                          label: 'المنطقة / الحي',
                          hint: 'أدخل المنطقة',
                          controller: _areaController,
                          errorText: _errors['area'],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AddressTextField(
                          label: 'المدينة',
                          hint: 'أدخل المدينة',
                          controller: _cityController,
                          errorText: _errors['city'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // ── رقم الهاتف ──
                  AddressTextField(
                    label: 'رقم الهاتف',
                    hint: '01xxxxxxxxx',
                    controller: _phoneController,
                    iconAsset: 'phone.svg',
                    keyboardType: TextInputType.phone,
                    errorText: _errors['phone'],
                  ),
                  const SizedBox(height: 18),

                  // ── العنوان بالتفصيل ──
                  AddressTextField(
                    label: 'العنوان بالتفصيل',
                    hint: 'الشارع، رقم المبنى، علامة مميزة',
                    iconAsset: 'location.svg',
                    controller: _addressController,
                    maxLines: 3,
                    errorText: _errors['address'],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  // ── App Bar ─────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppBackButton(),
          const Text(
            'إضافة عنوان جديد',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  // ── Bottom save button ──────────────────────────────────────────
  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            disabledBackgroundColor: AppColors.black.withValues(alpha: 0.5),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child:
              _isSubmitting
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : const Text(
                    'حفظ العنوان',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
