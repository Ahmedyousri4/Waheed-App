import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Notification bell icon with active/inactive state.
class NotificationButton extends StatelessWidget {
  final bool hasNotification;
  const NotificationButton({super.key, required this.hasNotification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight, width: 1.5),
        ),
        child: Center(
          child: AppImage(
            image:
                hasNotification
                    ? "notificationactive.svg"
                    : "notifications.svg",
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}

/// Search bar with optional filter icon.
class SearchBarWidget extends StatelessWidget {
  final bool showFilter;
  final String hintText;

  const SearchBarWidget({
    super.key,
    this.showFilter = true,
    this.hintText = "البحث عن منتج...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
            fontFamily: "Inter",
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(14.0),
            child: AppImage(image: "search.svg", height: 20, width: 20),
          ),
          suffixIcon:
              showFilter
                  ? const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: AppImage(image: "filter.svg", height: 20, width: 20),
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

/// Auto-scrolling banner carousel with page indicators.
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const _images = ["home.jpg", "homee.jpg", "homeee.jpg"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AppImage(image: _images[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color:
                    _currentPage == index
                        ? Colors.black
                        : AppColors.pageIndicator,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
