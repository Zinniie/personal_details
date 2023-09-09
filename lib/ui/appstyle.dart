import 'package:flutter/material.dart';

TextStyle appstyle(
  double size,
  Color color,
  FontWeight fw,
) {
  return TextStyle(fontSize: size, color: color, fontWeight: fw);
}

class CustomPaddedWidget extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;

  const CustomPaddedWidget({super.key, 
    required this.child,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: child,
    );
  }
}
