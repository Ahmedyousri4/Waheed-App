import 'package:flutter/material.dart';

/// Stylized presentation QR code visual matching Figma node 3526:6150.
///
/// ⚠️ Isolated visual asset for presentation only. Does NOT encode
/// live booking tokens or dynamic QR payload.
class BookingConfirmationQrVisual extends StatelessWidget {
  final double size;

  const BookingConfirmationQrVisual({super.key, this.size = 176});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CustomPaint(painter: _QrPresentationPainter()),
    );
  }
}

class _QrPresentationPainter extends CustomPainter {
  static const Color _navy = Color(0xFF314158);

  const _QrPresentationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = _navy
          ..style = PaintingStyle.fill;

    const int grid = 21;
    final double cellSize = size.width / grid;

    // Standard QR Version 1 grid modules representation (Figma node 3526:6150 pattern)
    const List<String> qrRows = [
      '111111100101001111111',
      '100000101000101000001',
      '101110100110001011101',
      '101110101001101011101',
      '101110100010101011101',
      '100000101100001000001',
      '111111101010101111111',
      '000000000101000000000',
      '101001110010101011010',
      '010100011101010010101',
      '101010101010101010101',
      '010011010101110100100',
      '101100101001001011011',
      '000000001101010100010',
      '111111100010101010101',
      '100000101001100101001',
      '101110100110010100110',
      '101110101001101010011',
      '101110100010100101100',
      '100000101100011010011',
      '111111101010101010101',
    ];

    for (int r = 0; r < grid; r++) {
      final String row = qrRows[r];
      for (int c = 0; c < grid; c++) {
        if (row[c] == '1') {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(c * cellSize, r * cellSize, cellSize, cellSize),
              const Radius.circular(1.5),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
