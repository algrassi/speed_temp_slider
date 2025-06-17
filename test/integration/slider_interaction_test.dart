import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

void main() {
  group('Slider Interaction Integration Tests', () {
    testWidgets('Temperature slider responds to pan gestures', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Find the gesture detector
      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);

      // Get the gesture detector widget
      final gestureDetectorWidgets = tester.widgetList<GestureDetector>(gestureDetectors);
      final hasOnPanUpdate = gestureDetectorWidgets.any((detector) => detector.onPanUpdate != null);
      expect(hasOnPanUpdate, isTrue);

      // Initially should show OFF
      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('Slider pan gesture simulation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Find the slider container specifically
      final containers = find.byType(Container);
      expect(containers, findsWidgets);

      // Find the rounded container (slider background)
      final sliderContainer = containers.at(1); // Usually the second container is the slider

      // Simulate a basic pan gesture on the slider area
      await tester.drag(sliderContainer, const Offset(0, -50));
      await tester.pump();

      // The test passes if no exceptions are thrown during the gesture
      expect(find.byType(TemperatureController), findsOneWidget);
    });

    testWidgets('Complete slider mode switching workflow', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Step 1: Verify initial state (temperature mode)
      expect(find.text('SPEED SLIDER'), findsOneWidget);
      expect(find.text('OFF'), findsOneWidget);

      // Step 2: Switch to speed mode
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Step 3: Verify speed mode
      expect(find.text('TEMPERATURE SLIDER'), findsOneWidget);
      expect(find.text('SLEEP'), findsOneWidget);

      // Step 4: Switch back to temperature mode
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Step 5: Verify back to temperature mode
      expect(find.text('SPEED SLIDER'), findsOneWidget);
      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('Slider visual elements count and structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Test specific widget counts that we can be sure about
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(AnimatedContainer), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);

      // Test widgets that may have multiple instances
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(Stack), findsWidgets); // Multiple stacks are expected

      // Verify at least one of each critical element exists
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(Text), findsAtLeastNWidgets(1));
      expect(find.byType(Stack), findsAtLeastNWidgets(1));
    });

    testWidgets('Text style is applied correctly across modes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Check temperature mode text style
      Text textWidget = tester.widget<Text>(find.text('OFF'));
      expect(textWidget.style?.fontSize, 48);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.white);

      // Switch to speed mode
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Check speed mode text style
      textWidget = tester.widget<Text>(find.text('SLEEP'));
      expect(textWidget.style?.fontSize, 48);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.white);
    });

    testWidgets('Widget hierarchy is correct', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Verify the widget hierarchy
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(TemperatureController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);

      // Should have provider scope (though it's internal)
      // We can't directly test for ProviderScope as it's internal to the plugin

      // Verify key interactive elements
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsWidgets); // Multiple text widgets
    });

    testWidgets('Temperature mode visual structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Verify we're in temperature mode
      expect(find.text('OFF'), findsOneWidget);
      expect(find.text('SPEED SLIDER'), findsOneWidget);

      // Check that essential visual components exist
      expect(find.byType(SizedBox), findsWidgets); // Spacing
      expect(find.byType(Positioned), findsWidgets); // For stack positioning
    });

    testWidgets('Speed mode visual structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Switch to speed mode
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify we're in speed mode
      expect(find.text('SLEEP'), findsOneWidget);
      expect(find.text('TEMPERATURE SLIDER'), findsOneWidget);

      // Check that the same visual structure exists in speed mode
      expect(find.byType(AnimatedContainer), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('Slider container properties', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Find containers and verify they have the expected properties
      final containers = tester.widgetList<Container>(find.byType(Container));

      // Should have multiple containers
      expect(containers.length, greaterThan(1));

      // At least one container should have a decoration with border radius
      final decoratedContainers = containers.where((container) => container.decoration != null && container.decoration is BoxDecoration && (container.decoration as BoxDecoration).borderRadius != null);

      expect(decoratedContainers, isNotEmpty);
    });

    testWidgets('Animation components are present', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TemperatureController()));

      // Check for animation-related widgets
      expect(find.byType(AnimatedContainer), findsOneWidget);

      // Verify the animated container has the expected duration
      final animatedContainer = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      expect(animatedContainer.duration, const Duration(milliseconds: 50));
    });
  });
}
