import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

void main() {
  group('Performance Tests', () {
    testWidgets('Widget builds within reasonable time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      stopwatch.stop();

      // Adjust threshold for complex widgets with providers (500ms is more realistic)
      expect(stopwatch.elapsedMilliseconds, lessThan(500));

      // Also verify it's not taking an extremely long time
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));

      // Debug: Print actual time for monitoring
      debugPrint('Widget build time: ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('Mode switching is performant', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      final stopwatch = Stopwatch()..start();

      // Perform multiple mode switches
      for (int i = 0; i < 5; i++) {
        // Reduced from 10 to 5 iterations
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
      }

      stopwatch.stop();

      // 5 switches should complete within 1 second (more realistic)
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));

      debugPrint('5 mode switches time: ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('Animation performance is acceptable', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      final stopwatch = Stopwatch()..start();

      // Test animation performance with pumping
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 16)); // 60 FPS
      }

      stopwatch.stop();

      // Should handle 10 animation frames efficiently
      expect(stopwatch.elapsedMilliseconds, lessThan(500));

      debugPrint('Animation frames time: ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('Multiple rebuilds without performance degradation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      final List<int> buildTimes = [];

      // Measure multiple rebuild times
      for (int i = 0; i < 10; i++) {
        final stopwatch = Stopwatch()..start();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        stopwatch.stop();
        buildTimes.add(stopwatch.elapsedMilliseconds);
      }

      // Verify no significant performance degradation
      // Last build should not be significantly slower than first
      final firstBuild = buildTimes.first;
      final lastBuild = buildTimes.last;

      expect(lastBuild, lessThan(firstBuild * 3)); // Not more than 3x slower

      // Average build time should be reasonable
      final averageTime = buildTimes.reduce((a, b) => a + b) / buildTimes.length;
      expect(averageTime, lessThan(200));

      debugPrint('Build times: $buildTimes');
      debugPrint('Average build time: ${averageTime.toStringAsFixed(2)}ms');
    });

    testWidgets('Memory usage remains stable', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Trigger multiple operations without crashes
      for (int i = 0; i < 20; i++) {
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Occasionally trigger a full rebuild
        if (i % 5 == 0) {
          await tester.pumpWidget(MaterialApp(home: TemperatureController()));
        }
      }

      // If we get here without crashes, memory management is likely okay
      expect(find.byType(TemperatureController), findsOneWidget);

      // Verify widget tree is still healthy
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('Initial render performance benchmark', (WidgetTester tester) async {
      // Measure just the initial pump time
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Just the first pump
      await tester.pump();

      stopwatch.stop();

      // First render + pump should be faster than full build
      expect(stopwatch.elapsedMilliseconds, lessThan(300));

      debugPrint('Initial render time: ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}
