import 'package:flutter/material.dart';

class VGap extends StatelessWidget {
  final double gap;
  const VGap(this.gap,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gap,
    );
  }
}