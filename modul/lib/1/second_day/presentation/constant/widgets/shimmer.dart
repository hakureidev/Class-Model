import 'package:flutter/material.dart';
import 'package:modul/1/second_day/presentation/constant/constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPage extends StatelessWidget {
  final double width, height;
  const ShimmerPage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Constant.baseColor,
        highlightColor: Constant.highlight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration:
                      BoxDecoration(color: Constant.baseColor.withOpacity(0.5) , shape: BoxShape.circle),
                )),
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Constant.width(context),
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Constant.baseColor.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Constant.baseColor.withOpacity(0.5)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
