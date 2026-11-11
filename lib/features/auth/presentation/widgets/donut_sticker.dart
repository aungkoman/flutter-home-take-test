import 'package:flutter/material.dart';

class DonutSticker extends StatelessWidget {
  const DonutSticker({
    super.key,
    required this.asset,
    required this.size,
    this.backgroundColor,
    this.rotation = 0,
  });

  final String asset;
  final double size;
  final Color? backgroundColor;
  final double rotation;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: backgroundColor == null
            ? null
            : [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      padding: EdgeInsets.all(size * 0.1),
      child: Transform.rotate(
        angle: rotation,
        child: Image.asset(asset, fit: BoxFit.contain),
      ),
    ),
  );
}
