import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/helpers/responsive.dart';

class ShimmerBox extends StatelessWidget {
  final double width, height, radius;
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDesktop = R.isDesktop(context);
    final p = isDesktop ? 20.0 : 16.0;
    return Card(
      margin: EdgeInsets.only(bottom: isDesktop ? 0 : 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 18 : 16),
      ),
      child: Shimmer.fromColors(
        baseColor: cs.surfaceContainerHighest,
        highlightColor: cs.surface,
        child: Padding(
          padding: EdgeInsets.all(p),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerBox(width: 180, height: 16, radius: 6),
                  ShimmerBox(width: 70, height: 24, radius: 12),
                ],
              ),
              const SizedBox(height: 14),
              const ShimmerBox(width: 120, height: 12, radius: 6),
              const SizedBox(height: 16),
              const ShimmerBox(width: double.infinity, height: 12, radius: 6),
              const SizedBox(height: 8),
              const ShimmerBox(width: double.infinity, height: 12, radius: 6),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerBox(width: 80, height: 32, radius: 10),
                  ShimmerBox(width: 110, height: 32, radius: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerListView extends StatelessWidget {
  final int itemCount;
  final Widget Function() itemBuilder;
  const ShimmerListView({
    super.key,
    this.itemCount = 4,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.padding(context)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
          itemCount,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: itemBuilder(),
          ),
        ),
      ),
    );
  }
}
