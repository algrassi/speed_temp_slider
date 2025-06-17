import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/src/widgets/text_widget_value.dart';
import 'package:speed_temp_slider/src/utils.dart';

void main() {
  group('TextWidgetValue Tests', () {
    testWidgets('displays OFF for temperature <= 5.0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TextWidgetValue(value: 5.0, type: SliderValueType.temperature)),
        ),
      );

      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('displays temperature value with °C for temperature > 5.0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TextWidgetValue(value: 15.5, type: SliderValueType.temperature)),
        ),
      );

      expect(find.text('15.5 °C'), findsOneWidget);
    });

    testWidgets('displays SLEEP for speed value 0-9', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextWidgetValue(
              value: 5.0, // (5.0 / 10).toInt() = 0
              type: SliderValueType.speed,
            ),
          ),
        ),
      );

      expect(find.text('SLEEP'), findsOneWidget);
    });

    testWidgets('displays Vel1 for speed value 10-19', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextWidgetValue(
              value: 15.0, // (15.0 / 10).toInt() = 1
              type: SliderValueType.speed,
            ),
          ),
        ),
      );

      expect(find.text('Vel1'), findsOneWidget);
    });

    testWidgets('has correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TextWidgetValue(value: 20.0, type: SliderValueType.temperature)),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, 48);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.white);
    });
  });
}
