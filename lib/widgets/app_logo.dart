import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/resticon.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
