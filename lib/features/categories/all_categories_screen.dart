import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/home/widgets/home_widgets.dart';

/// All categories listing screen.
class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: AppBackButton(onTap: () => Navigator.pop(context)),
        ),
        centerTitle: true,
        title: const Text(
          "كل التصنيفات",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SearchBarWidget(
                showFilter: false,
                hintText: "البحث عن تصنيف...",
              ),
              const SizedBox(height: 24),
              _buildCategoryItem("قمصان", "shirts.svg"),
              const SizedBox(height: 12),
              _buildCategoryItem("بدلات", "suits.svg"),
              const SizedBox(height: 12),
              _buildCategoryItem("أحذية", "shoes.svg"),
              const SizedBox(height: 12),
              _buildCategoryItem("اكسسوارات", "accessories.svg"),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String icon) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight, width: 1.5),
            ),
            child: AppImage(image: icon, height: 24, width: 24),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: "Inter",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
