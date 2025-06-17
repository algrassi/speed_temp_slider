import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

void main() {
  group('TemperatureController Tests', () {
    testWidgets('TemperatureController renders without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Verify that the widget tree is built successfully
      expect(find.byType(TemperatureController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Initial state shows temperature slider and correct button text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Should start in temperature mode
      expect(find.text('SPEED SLIDER'), findsOneWidget);
      expect(find.text('TEMPERATURE SLIDER'), findsNothing);
    });

    testWidgets('Button toggles between temperature and speed sliders', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Initially should show "SPEED SLIDER" button (meaning temp slider is active)
      expect(find.text('SPEED SLIDER'), findsOneWidget);

      // Tap the button to switch to speed slider
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Now should show "TEMPERATURE SLIDER" button (meaning speed slider is active)
      expect(find.text('TEMPERATURE SLIDER'), findsOneWidget);
      expect(find.text('SPEED SLIDER'), findsNothing);

      // Tap again to switch back
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should be back to temperature slider
      expect(find.text('SPEED SLIDER'), findsOneWidget);
    });

    testWidgets('Temperature slider shows OFF for initial value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Should show "OFF" for temperature <= 5.0
      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('Speed slider shows SLEEP for initial value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Switch to speed slider
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show "SLEEP" for initial speed value
      expect(find.text('SLEEP'), findsOneWidget);
    });

    testWidgets('Gesture detector is present for slider interaction', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Should have a gesture detector for slider interaction
      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);

      final gestureDetectorWidgets = tester.widgetList<GestureDetector>(gestureDetectors);
      final hasOnPanUpdate = gestureDetectorWidgets.any((detector) => detector.onPanUpdate != null);
      expect(hasOnPanUpdate, isTrue);
    });
  });
}
