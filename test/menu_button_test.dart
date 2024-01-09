import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kolor_klash/widgets/menu_button.dart';

void main() {
  const String buttonTextValue = 'Button Test';
  bool wasPressed = false;

  // Implementations for the 'onPressed' function
  onPressedTest() {
    wasPressed = true;
  }

  // Test Widgets
  testWidgets('Check if MenuButton is created', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MenuButton(buttonText: buttonTextValue, onPressed: onPressedTest),
      ),
    ));

    expect(find.byType(MenuButton), findsOneWidget);
  });

  testWidgets('Check if MenuButton text is correctly set', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MenuButton(buttonText: buttonTextValue, onPressed: onPressedTest),
      ),
    ));

    expect(find.text(buttonTextValue), findsOneWidget);
  });

  testWidgets('Check if MenuButton was pressed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MenuButton(buttonText: buttonTextValue, onPressed: onPressedTest),
      ),
    ));

    // simulate a press on the button
    await tester.tap(find.byType(MenuButton));
    await tester.pump();

    // verify if the button has been pressed
    expect(wasPressed, true);
  });
}
