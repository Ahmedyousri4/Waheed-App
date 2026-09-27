import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/core/widgets/cart_badge_button.dart';
import 'package:waheed/core/widgets/product_card.dart';
import 'package:waheed/features/home/widgets/home_widgets.dart';

/// Latest products listing screen.
class LatestProductsScreen extends StatelessWidget {
  const LatestProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBackButton(onTap: () => Navigator.pop(context)),
        ),
        centerTitle: true,
        title: const Text(
          "كل المنتجات",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: CartBadgeButton(count: 2)),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              SearchBarWidget(),
              SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProductCard(
                      image: "blacksuit.png",
                      title: "بدلة كلاسيكية سوداء",
                      subtitle: "صوف إيطالي فاخر",
                      price: "2,450",
                      rating: "4.9",
                      reviews: "128",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ProductCard(
                      image: "bluesuit.png",
                      title: "بدلة كلاسيكية سوداء",
                      subtitle: "صوف إيطالي فاخر",
                      price: "2,450",
                      rating: "4.9",
                      reviews: "128",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProductCard(
                      image: "blacksuit.png",
                      title: "بدلة كلاسيكية سوداء",
                      subtitle: "صوف إيطالي فاخر",
                      price: "2,450",
                      rating: "4.9",
                      reviews: "128",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ProductCard(
                      image: "bluesuit.png",
                      title: "بدلة كلاسيكية سوداء",
                      subtitle: "صوف إيطالي فاخر",
                      price: "2,450",
                      rating: "4.9",
                      reviews: "128",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
