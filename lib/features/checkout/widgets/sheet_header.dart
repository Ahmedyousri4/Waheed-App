import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Reusable header for modal bottom sheets.
///
/// Renders a gray drag-handle pill (visual only), a close "X" button
/// at the start (right in RTL), and a truly centered title via [Stack].
class SheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const SheetHeader({super.key, required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Drag handle (visual only) ──
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Close + centered title ──
        SizedBox(
          height: 28,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: onClose,
                child: const Icon(
                  Icons.close,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
