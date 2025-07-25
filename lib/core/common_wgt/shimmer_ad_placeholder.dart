import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class ShimmerAdPlaceholder extends StatelessWidget {
  const ShimmerAdPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: skyColor.withAlpha(100),
        highlightColor: skyColor.withAlpha(60),
        period: const Duration(seconds: 2),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: shimmerPlaceholderDecoration,
        ),
      ),
    );
  }
}
