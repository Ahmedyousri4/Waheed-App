import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/features/checkout/checkout_screen.dart';
import 'package:waheed/features/suit_measurements/widgets/step_indicators.dart';
import 'package:waheed/features/suit_measurements/widgets/step_header.dart';
import 'package:waheed/features/suit_measurements/widgets/guide_card.dart';
import 'package:waheed/features/suit_measurements/widgets/size_selector.dart';
import 'package:waheed/features/suit_measurements/widgets/measurements_card.dart';
import 'package:waheed/features/suit_measurements/widgets/review_widgets.dart';

/// 4-step suit measurement wizard.
///
/// Decomposed from the original 1141-line monolith. This screen now
/// only handles page composition, step navigation, and controller
/// lifecycle. All UI sections live in dedicated widget files.
class SuitMeasurementsScreen extends StatefulWidget {
  final String productImage;
  final String productTitle;
  final String productSubtitle;
  final String productPrice;

  const SuitMeasurementsScreen({
    super.key,
    this.productImage = 'blacksuit.png',
    this.productTitle = 'بدلة رجالية رمادي فاخرة',
    this.productSubtitle = 'صوف إيطالي فاخر',
    this.productPrice = '1,800',
  });

  @override
  State<SuitMeasurementsScreen> createState() => _SuitMeasurementsScreenState();
}

class _SuitMeasurementsScreenState extends State<SuitMeasurementsScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  int _selectedSize = -1;
  int _reviewSelectedSize = -1;

  OverlayEntry? _overlayEntry;
  late AnimationController _notifController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // ── Controllers ──────────────────────────────────────────────────
  final _jacketChest = TextEditingController();
  final _jacketShoulder = TextEditingController();
  final _jacketSleeve = TextEditingController();
  final _jacketLength = TextEditingController();

  final _shirtNeck = TextEditingController();
  final _shirtChest = TextEditingController();
  final _shirtSleeve = TextEditingController();
  final _shirtLength = TextEditingController();

  final _pantsWaist = TextEditingController();
  final _pantsHip = TextEditingController();
  final _pantsInseam = TextEditingController();
  final _pantsLength = TextEditingController();

  static const _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  static const _reviewSizes = ['28', '30', '32', '34', '36'];

  @override
  void initState() {
    super.initState();
    _notifController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _notifController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _notifController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _notifController.dispose();
    _jacketChest.dispose();
    _jacketShoulder.dispose();
    _jacketSleeve.dispose();
    _jacketLength.dispose();
    _shirtNeck.dispose();
    _shirtChest.dispose();
    _shirtSleeve.dispose();
    _shirtLength.dispose();
    _pantsWaist.dispose();
    _pantsHip.dispose();
    _pantsInseam.dispose();
    _pantsLength.dispose();
    super.dispose();
  }

  // ── Success notification overlay ────────────────────────────────
  void _showSuccessNotification() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _overlayEntry = OverlayEntry(builder: (_) => _buildNotificationOverlay());

    Overlay.of(context).insert(_overlayEntry!);
    _notifController.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (_overlayEntry != null) {
        _notifController.reverse().then((_) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          if (mounted) {
            // Add the selected suit to cart before navigating to checkout
            final price = double.tryParse(
                  widget.productPrice.replaceAll(',', ''),
                ) ??
                0;
            if (!CartManager.isInCart(widget.productImage, widget.productTitle)) {
              CartManager.addToCart({
                'image': widget.productImage,
                'title': widget.productTitle,
                'subtitle': widget.productSubtitle,
                'price': price,
                'type': 'إيجار',
              });
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
            );
          }
        });
      }
    });
  }

  Widget _buildNotificationOverlay() {
    final topPadding = MediaQuery.of(context).padding.top;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: 90,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, topPadding + 12, 20, 14),
            decoration: const BoxDecoration(
              color: Color(0xE545AA7B),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.done, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
                const Text(
                  "تم حفظ القياسات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Measurement field configs per step ───────────────────────────
  List<Map<String, dynamic>> _getFields() {
    switch (_currentStep) {
      case 0:
        return [
          {
            'label': 'محيط الصدر',
            'desc': 'حول أوسع جزء من الصدر',
            'controller': _jacketChest,
            'placeholder': '94',
          },
          {
            'label': 'عرض الكتفين',
            'desc': 'من كتف إلى كتف',
            'controller': _jacketShoulder,
            'placeholder': '44',
          },
          {
            'label': 'طول الكم',
            'desc': 'من الكتف إلى المعصم',
            'controller': _jacketSleeve,
            'placeholder': '62',
          },
          {
            'label': 'طول الجاكيت',
            'desc': 'من الرقبة إلى الذيل السفلي',
            'controller': _jacketLength,
            'placeholder': '70',
          },
        ];
      case 1:
        return [
          {
            'label': 'محيط الرقبة',
            'desc': 'حول قاعدة الرقبة',
            'controller': _shirtNeck,
            'placeholder': '39',
          },
          {
            'label': 'محيط الصدر',
            'desc': 'حول أوسع جزء من الصدر',
            'controller': _shirtChest,
            'placeholder': '96',
          },
          {
            'label': 'طول الكم',
            'desc': 'من الكتف إلى المعصم',
            'controller': _shirtSleeve,
            'placeholder': '64',
          },
          {
            'label': 'طول القميص',
            'desc': 'من الرقبة إلى الذيل',
            'controller': _shirtLength,
            'placeholder': '76',
          },
        ];
      case 2:
        return [
          {
            'label': 'محيط الخصر',
            'desc': 'عند منطقة السرة',
            'controller': _pantsWaist,
            'placeholder': '39',
          },
          {
            'label': 'محيط الورك',
            'desc': 'حول أوسع جزء من الورك',
            'controller': _pantsHip,
            'placeholder': '94',
          },
          {
            'label': 'طول الساق الداخلي',
            'desc': 'من الفخذ الداخلي إلى الكاحل',
            'controller': _pantsInseam,
            'placeholder': '62',
          },
          {
            'label': 'طول البنطلون',
            'desc': 'من الخصر إلى الحافة',
            'controller': _pantsLength,
            'placeholder': '62',
          },
        ];
      default:
        return [];
    }
  }

  // ── Review measurement data ─────────────────────────────────────
  List<Map<String, String>> _jacketReview() => [
    {'محيط الصدر': _jacketChest.text.isEmpty ? '94' : _jacketChest.text},
    {'عرض الكتفين': _jacketShoulder.text.isEmpty ? '44' : _jacketShoulder.text},
    {'طول الكم': _jacketSleeve.text.isEmpty ? '62' : _jacketSleeve.text},
    {'طول الجاكيت': _jacketLength.text.isEmpty ? '70' : _jacketLength.text},
  ];

  List<Map<String, String>> _shirtReview() => [
    {'محيط الرقبة': _shirtNeck.text.isEmpty ? '39' : _shirtNeck.text},
    {'محيط الصدر': _shirtChest.text.isEmpty ? '96' : _shirtChest.text},
    {'طول الكم': _shirtSleeve.text.isEmpty ? '64' : _shirtSleeve.text},
    {'طول القميص': _shirtLength.text.isEmpty ? '76' : _shirtLength.text},
  ];

  List<Map<String, String>> _pantsReview() => [
    {'محيط الخصر': _pantsWaist.text.isEmpty ? '39' : _pantsWaist.text},
    {'محيط الورك': _pantsHip.text.isEmpty ? '94' : _pantsHip.text},
    {'طول الساق الداخلي': _pantsInseam.text.isEmpty ? '62' : _pantsInseam.text},
    {'طول البنطلون': _pantsLength.text.isEmpty ? '62' : _pantsLength.text},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceMeasurements,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicators(
                    currentStep: _currentStep,
                    onStepTap: (s) => setState(() => _currentStep = s),
                  ),
                  const SizedBox(height: 24),
                  StepHeader(currentStep: _currentStep),
                  const SizedBox(height: 20),
                  if (_currentStep == 3)
                    ..._buildReviewContent()
                  else
                    ..._buildStepContent(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildNavigationBar(),
        ],
      ),
    );
  }

  List<Widget> _buildStepContent() => [
    GuideCard(currentStep: _currentStep),
    const SizedBox(height: 20),
    SizeSelector(
      sizes: _sizes,
      selectedIndex: _selectedSize,
      onSelected: (i) => setState(() => _selectedSize = i),
      showBadge: true,
    ),
    const SizedBox(height: 20),
    MeasurementsCard(fields: _getFields()),
  ];

  List<Widget> _buildReviewContent() => [
    const ReviewSummaryCard(),
    const SizedBox(height: 20),
    SizeSelector(
      sizes: _reviewSizes,
      selectedIndex: _reviewSelectedSize,
      onSelected: (i) => setState(() => _reviewSelectedSize = i),
      showBadge: true,
    ),
    const SizedBox(height: 20),
    ReviewSectionCard(
      icon: "jacket.svg",
      title: "الجاكيت",
      stepIndex: 0,
      items: _jacketReview(),
      onEdit: (s) => setState(() => _currentStep = s),
    ),
    const SizedBox(height: 16),
    ReviewSectionCard(
      icon: "shirt.svg",
      title: "القميص",
      stepIndex: 1,
      items: _shirtReview(),
      onEdit: (s) => setState(() => _currentStep = s),
    ),
    const SizedBox(height: 16),
    ReviewSectionCard(
      icon: "trousers.svg",
      title: "البنطلون",
      stepIndex: 2,
      items: _pantsReview(),
      onEdit: (s) => setState(() => _currentStep = s),
    ),
    const SizedBox(height: 20),
    const ReviewInfoNotice(),
  ];

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
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: AppImage(image: "arrowleft.svg", height: 18, width: 18),
              ),
            ),
          ),
          const Text(
            "قياسات البدلة",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 42),
        ],
      ),
    );
  }

  // ── Bottom navigation buttons ───────────────────────────────────
  Widget _buildNavigationBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _currentStep--),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider, width: 1.5),
                    ),
                    child: const Center(
                      child: Text(
                        "السابق",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (_currentStep < 3) {
                    setState(() => _currentStep++);
                  } else {
                    _showSuccessNotification();
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Ink(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentStep == 3 ? "المتابعة لإتمام الطلب" : "التالي",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                        ),
                      ),
                      const SizedBox(width: 8),
                      const AppImage(
                        image: "arrowlift.svg",
                        height: 18,
                        width: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
