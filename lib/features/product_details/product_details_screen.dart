import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/widgets/cart_badge_button.dart';
import 'package:waheed/features/product_details/widgets/product_sections.dart';
import 'package:waheed/features/product_details/widgets/product_extras.dart';
import 'package:waheed/features/product_details/widgets/purchase_widgets.dart';

/// Product details screen showing a full product page with
/// image gallery, info, features, colors, description, and purchase bar.
///
/// Decomposed from the original 896-line monolith.
class ProductDetailsScreen extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final String productSubtitle;
  final String productPrice;

  const ProductDetailsScreen({
    super.key,
    this.productImage = 'blacksuit.png',
    this.productTitle = 'بدلة رجالية رمادي فاخرة',
    this.productSubtitle = 'صوف إيطالي فاخر',
    this.productPrice = '1,800',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 16),
                    ProductImageSection(),
                    SizedBox(height: 16),
                    ProductGallery(),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ProductInfoSection(),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: FeatureCardsRow(),
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ColorSelectorSection(),
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DescriptionSection(),
                    ),
                    SizedBox(height: 28),
                    SimilarProductsSection(),
                    SizedBox(height: 160),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomPurchaseBar(
              productImage: productImage,
              productTitle: productTitle,
              productSubtitle: productSubtitle,
              productPrice: productPrice,
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      toolbarHeight: 64,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 44,
              width: 44,
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
            "تفاصيل المنتج",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
          const CartBadgeButton(count: 2),
        ],
      ),
    );
  }
}
