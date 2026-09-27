/// Data model for a saved delivery address.
class AddressModel {
  final String name;
  final String phone;
  final String city;
  final String area;
  final String detailedAddress;
  final String label;
  final bool isDefault;

  const AddressModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.area,
    required this.detailedAddress,
    this.label = 'المنزل',
    this.isDefault = true,
  });

  /// Short display string for the checkout summary.
  String get displayAddress => '$city، $area';

  /// Full display with name and phone.
  String get displayFull => '$name • $phone\n$displayAddress';
}
