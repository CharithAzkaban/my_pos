import 'package:flutter/material.dart';

class HGap extends StatelessWidget {
  final double gap;
  const HGap(this.gap,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
    );
  }
}