import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.totalPercent, required this.baseColor, required this.overflowColor}) : super(key: key);

  final double totalPercent;
  final Color baseColor;
  final Color overflowColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 11,
        child: Stack(
          // alignment: Alignment.centerRight,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10)
                      ),
            ),
            FractionallySizedBox(
              widthFactor: totalPercent,
              child: Container(
                decoration:  BoxDecoration(
                    color: overflowColor,
                    borderRadius: BorderRadius.circular(10)
                        ),
              ),
            )
          ],
        ));
  }
}
