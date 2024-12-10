import 'package:flutter/material.dart';

import '../constant/size.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({
    super.key,
    this.foregroundColor = Colors.white,
    this.backgroundColor = Colors.blue,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CustomSize.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(color: foregroundColor, backgroundColor: Colors.transparent),
      ),
    );
  }
}