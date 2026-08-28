import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double borderRadiusFactor;

  const AppLogo({
    super.key,
    this.size = 64,
    this.borderRadiusFactor = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * borderRadiusFactor),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: size * 0.3,
            offset: Offset(0, size * 0.12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/resticon.png',
        width: size * 0.68,
        height: size * 0.68,
        fit: BoxFit.contain,
      ),
    );
  }
}
