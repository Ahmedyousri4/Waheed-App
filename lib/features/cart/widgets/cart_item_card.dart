import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Individual cart item card with product image, details,
/// price, quantity stepper, and delete button.
class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 104,
              height: 120,
              child: AppImage(image: item['image'], fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: _buildDetails()),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          item['title'],
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 4),
        Text(
          item['subtitle'] ?? '',
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            color: Color(0xFF909090),
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 4),
        Text(
          item['type'] ?? 'إيجار',
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            color: Color(0xFF606060),
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'ج.م',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF909090),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 2),
            Text(
              '${item['price']}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Inter',
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildControls(),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        GestureDetector(
          onTap: onDelete,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onIncrement,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Icon(Icons.add, size: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '${item['quantity']}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDecrement,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Icon(Icons.remove, size: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
