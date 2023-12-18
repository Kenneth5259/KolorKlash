import 'package:flutter/material.dart';

class FlexColumn extends StatelessWidget {
  final Color? color;
  const FlexColumn({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
