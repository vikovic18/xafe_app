import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key}) : super(key: key);

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
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                      ),
            ),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: Container(
                decoration:  BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)
                        ),
              ),
            )
          ],
        ));
  }
}
