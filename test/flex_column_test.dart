import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kolor_klash/widgets/flex_column.dart'; // path to your FlexColumn file

void main() {
  group('FlexColumn', () {
    testWidgets('default color is white', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Row(children: [FlexColumn()]))),
      );
      final column = tester.widget<FlexColumn>(find.byType(FlexColumn));
      expect(column.color, Colors.white);
    });

    testWidgets('default color can be overridden', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Row(children: [FlexColumn(color: Colors.red)]))),
      );
      final column = tester.widget<FlexColumn>(find.byType(FlexColumn));
      expect(column.color, Colors.red);
    });

    testWidgets('direction gradient check', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Row(children: [FlexColumn()]))),
      );
      final container = tester.widget<Container>(find.byType(Container).last);
      final boxDecoration = container.decoration as BoxDecoration;
      final gradient = boxDecoration.gradient as LinearGradient;
      expect(gradient.begin, Alignment.bottomCenter);
      expect(gradient.end, Alignment.topCenter);
    });
  });
}
