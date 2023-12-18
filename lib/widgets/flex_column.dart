import 'package:flutter/material.dart';

class FlexColumn extends StatelessWidget {
  final Color? color;
  const FlexColumn({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
