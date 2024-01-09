import 'package:flutter/material.dart';

class FlexColumn extends StatefulWidget {
  static const radius = Radius.circular(5);
  static const borderColor = Colors.black12;
  final Color? color;
  final bool isAnimated;

  const FlexColumn({Key? key, this.color = Colors.white, this.isAnimated = true})
      : super(key: key);

  @override
  _FlexColumnState createState() => _FlexColumnState();
}

class _FlexColumnState extends State<FlexColumn> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.color ?? Colors.white;
  }

  @override
  void didUpdateWidget(covariant FlexColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      setState(() {
        _color = widget.color ?? Colors.white;
      });
    }
  }

  BoxDecoration _buildBoxDecoration(Color color) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(FlexColumn.radius),
      border: Border.all(color: FlexColumn.borderColor),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white,
          color,
          color == Colors.white ? Colors.white : Colors.black,
        ],
        stops: const [-0.5, 0.9, 1.4],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: widget.isAnimated
          ? AnimatedContainer(
        duration: Duration(milliseconds: 330),
        curve: Curves.easeIn,
        decoration: _buildBoxDecoration(_color),
      )
          : Container(
        decoration: _buildBoxDecoration(_color),
      ),
    );
  }
}
