import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Row of 3 feature badges (quality, delivery, guarantee).
class FeatureCardsRow extends StatelessWidget {
  const FeatureCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FeatureCard(icon: "quality.svg", label: "جودة عالية"),
        _FeatureCard(icon: "car.svg", label: "توصيل 3-7 أيام"),
        _FeatureCard(icon: "trust.svg", label: "ضمان التفصيل"),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String icon;
  final String label;
  const _FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 79,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage(image: icon, height: 26, width: 26),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Color selector with animated selection circles.
class ColorSelectorSection extends StatefulWidget {
  const ColorSelectorSection({super.key});

  @override
  State<ColorSelectorSection> createState() => _ColorSelectorSectionState();
}

class _ColorSelectorSectionState extends State<ColorSelectorSection> {
  int _selected = 3;
  static const _colors = [
    Color(0xFFC9B79C),
    Color(0xFF1A1A1A),
    Color(0xFF172554),
    Color(0xFF3F4651),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اللون",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "رمادي داكن",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Row(
          children: List.generate(_colors.length, (i) {
            final sel = _selected == i;
            return GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(left: i < _colors.length - 1 ? 10 : 0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: _colors[i],
                  shape: BoxShape.circle,
                  border:
                      sel ? Border.all(color: Colors.white, width: 3) : null,
                  boxShadow:
                      sel
                          ? [
                            BoxShadow(
                              color: _colors[i].withValues(alpha: 0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                            const BoxShadow(
                              color: AppColors.border,
                              blurRadius: 0,
                              spreadRadius: 2,
                            ),
                          ]
                          : null,
                ),
                child:
                    sel
                        ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 20,
                        )
                        : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Description text with tag chips.
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "الوصف",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "بدلة رجالية كلاسيكية بقصة عصرية أنيقة، مصنوعة من أجود الأقمشة وتُفصّل خصيصاً وفقاً لقياساتك التي تدخلها عبر معالج القياسات. مثالية للمناسبات الرسمية والاجتماعات.",
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Inter",
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _TagChip(text: "خياطة يدوية"),
            _TagChip(text: "بطانة حريرية"),
            _TagChip(text: "قصة سليم فيت"),
          ],
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  const _TagChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
          color: AppColors.gold,
        ),
      ),
    );
  }
}
