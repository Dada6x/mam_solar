import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';

/// Paints a dashed rounded-rectangle border (no external package needed).
class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedRRectPainter({required this.color, this.radius = 12});

  // Fixed dash geometry (same for every box in the app).
  static const double _strokeWidth = 1.4;
  static const double _dash = 6;
  static const double _gap = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double dist = 0;
      while (dist < metric.length) {
        final next = dist + _dash;
        canvas.drawPath(
          metric.extractPath(dist, next.clamp(0, metric.length).toDouble()),
          paint,
        );
        dist = next + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color || old.radius != radius;
}

/// A box with a dashed rounded border around its [child] (smapOne upload look).
class DashedBox extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double radius;

  const DashedBox({
    super.key,
    required this.child,
    this.borderColor = AppColors.dashedBorderGrey,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(color: borderColor, radius: radius),
      child: child,
    );
  }
}

/// smapOne-style "Foto" box: one dashed box split into a camera and a gallery
/// cell, both rendered in the brand blue. Used by the single- and multi-photo
/// fields so capture/upload looks identical to smapOne.
class PhotoSourceBox extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final String cameraLabel;
  final String galleryLabel;

  const PhotoSourceBox({
    super.key,
    required this.onCamera,
    required this.onGallery,
    required this.cameraLabel,
    required this.galleryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DashedBox(
      child: SizedBox(
        height: 92,
        child: Row(
          children: [
            Expanded(child: _cell(Icons.camera_alt_outlined, cameraLabel, onCamera)),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(vertical: 18),
              color: AppColors.dashedBorderGrey,
            ),
            Expanded(child: _cell(Icons.photo_library_outlined, galleryLabel, onGallery)),
          ],
        ),
      ),
    );
  }

  Widget _cell(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
