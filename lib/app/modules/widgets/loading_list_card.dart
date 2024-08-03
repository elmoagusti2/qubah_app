import 'package:flutter/material.dart';

import 'shimmer.dart';

class LoadingListCard extends StatelessWidget {
  final int? count;
  final double? heightCard;
  final Color? baseColor;
  final Color? highColor;
  final Color? backgroundColor;
  const LoadingListCard(
      {super.key,
      this.count,
      this.heightCard,
      this.baseColor,
      this.highColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: count ?? 10,
      itemBuilder: (context, index) => Container(
        height: heightCard ?? 60,
        margin: const EdgeInsets.only(top: 2, bottom: 6),
        child: Stack(
          children: [
            Shimmers.shimmerCustom(
              height: heightCard ?? 60,
              baseColor: backgroundColor ?? const Color(0xFFcccccc),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  Shimmers.shimmerCustom(
                    width: 50,
                    height: 50,
                    circular: 100,
                    baseColor: baseColor ?? Colors.grey[400],
                    highColor: highColor ?? const Color(0xFFcccccc),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmers.shimmerCustom(
                        width: 150,
                        height: 10,
                        baseColor: baseColor ?? Colors.grey[400],
                        highColor: highColor ?? const Color(0xFFcccccc),
                      ),
                      const SizedBox(height: 8),
                      Shimmers.shimmerCustom(
                        width: 200,
                        height: 10,
                        baseColor: baseColor ?? Colors.grey[400],
                        highColor: highColor ?? const Color(0xFFcccccc),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
