import 'package:flutter/material.dart';

class StraightArrow extends StatelessWidget {
  final double length;
  final double width;
  final Color color;
  final double strokeWidth;

  const StraightArrow({
    super.key,
    required this.length,
    required this.width,
    required this.color,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(length, width),
      painter: ArrowPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  ArrowPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final arrowPath = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width - size.height / 2, size.height / 2)
      ..lineTo(size.width - size.height / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - size.height / 2, size.height)
      ..lineTo(size.width - size.height / 2, size.height / 2)
      ..lineTo(0, size.height / 2);

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
