import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

void main() {
  group('Golden Tests', () {
    testWidgets('TemperatureController initial state golden test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      await tester.pump();

      // Take a screenshot and compare with golden file
      await expectLater(find.byType(TemperatureController), matchesGoldenFile('temperature_controller_initial.png'));
    });

    testWidgets('TemperatureController speed mode golden test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Switch to speed mode
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Take a screenshot and compare with golden file
      await expectLater(find.byType(TemperatureController), matchesGoldenFile('temperature_controller_speed_mode.png'));
    });
  });
}
