/// Data model for a pickup branch location.
class BranchModel {
  final String name;
  final String address;

  const BranchModel({required this.name, required this.address});

  /// Default branch used when no branch selection flow exists yet.
  static const BranchModel defaultBranch = BranchModel(
    name: 'الفرع الرئيسي - ميت غمر',
    address: 'ميت غمر، شارع المعاهده بجوار كلية التربية النوعية',
  );
}
