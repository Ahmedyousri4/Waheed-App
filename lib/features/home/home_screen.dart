import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/home/widgets/home_widgets.dart';
import 'package:waheed/features/home/widgets/home_sections.dart';
import 'package:waheed/features/favorites/favorites_screen.dart';
import 'package:waheed/features/categories/all_categories_screen.dart';
import 'package:waheed/features/products/latest_products_screen.dart';
import 'package:waheed/features/cart/cart_screen.dart';

class _NavItem {
  final String title;
  final String icon;
  final String activeIcon;
  final Widget page;

  _NavItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}

/// Root home screen with bottom navigation bar.
///
/// Decomposed from the original 864-line monolith. All section
/// widgets now live in dedicated files under features/home/widgets/.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool hasNotification = true;

  late final List<_NavItem> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      _NavItem(
        title: "الرئيسية",
        icon: "home.svg",
        activeIcon: "homeselected.svg",
        page: const _HomeBody(),
      ),
      _NavItem(
        title: "طلباتي",
        icon: "orders.svg",
        activeIcon: "orderselected.svg",
        page: const Scaffold(body: Center(child: Text("طلباتي"))),
      ),
      _NavItem(
        title: "العربة",
        icon: "cart.svg",
        activeIcon: "cartselected.svg",
        page: const CartScreen(),
      ),
      _NavItem(
        title: "حسابي",
        icon: "profile.svg",
        activeIcon: "profileselected.svg",
        page: const Scaffold(body: Center(child: Text("حسابي"))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _tabs[_currentIndex].page,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 60,
      title: Row(
        children: [
          const AppImage(image: "logo.svg", height: 36, width: 36),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "WAHEED HASSAN",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Text(
                "MEN'S SUITS",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                ),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight, width: 1.5),
              ),
              child: const Center(
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          NotificationButton(hasNotification: hasNotification),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_tabs.length, (index) {
              final item = _tabs[index];
              final isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppImage(
                        image: isSelected ? item.activeIcon : item.icon,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Inter",
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w600,
                          color:
                              isSelected ? Colors.black : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Home tab body: search + carousel + categories + products.
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const SearchBarWidget(),
            const SizedBox(height: 24),
            const BannerCarousel(),
            const SizedBox(height: 24),
            CategoriesSection(
              onViewAll:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AllCategoriesScreen(),
                    ),
                  ),
            ),
            const SizedBox(height: 24),
            ProductsSection(
              onViewMore:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LatestProductsScreen(),
                    ),
                  ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
