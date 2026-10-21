import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Animated success emblem with gradient circle, check icon, and gold badge.
///
/// Displays a 128×128 dark gradient circle with a white tick icon,
/// overlaid with a 40×40 gold badge containing a smaller check.
/// Matches Figma node hierarchy: 3526:5451 → 3526:5458.
class SuccessEmblem extends StatelessWidget {
  const SuccessEmblem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Main gradient circle with check icon ───────────────────
          Container(
            width: 128,
            height: 128,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(-0.7, -0.7), // ~135°
                end: Alignment(0.7, 0.7),
                colors: [
                  Color(0xFF455A64), // slate-grey
                  Color(0xFF000000), // black
                ],
              ),
            ),
            child: const Center(
              child: AppImage(image: 'done.svg', width: 64, height: 64),
            ),
          ),

          // ── Gold badge with small check ────────────────────────────
          // Positioned at bottom-left per Figma (x -8, y 96 relative
          // to the 128×128 emblem).
          Positioned(
            left: -8,
            top: 96,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 7.5,
                    color: Color(0x1A000000), // rgba(0,0,0,0.1)
                  ),
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 3,
                    color: Color(0x1A000000),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.check_rounded, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
