import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/flex_column.dart';

class GameTile extends StatelessWidget {
  const GameTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child:  const Row(
              children: [
                FlexColumn(color: Colors.red),
                FlexColumn(color: Colors.yellow),
                FlexColumn(color: Colors.blue),
              ],
        ),
      ),
    );
  }
}
