import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/src/providers/temperature_providers.dart';

void main() {
  group('Temperature Providers Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('temperatureProvider has initial value of 5.0', () {
      final temperature = container.read(temperatureProvider);
      expect(temperature, 5.0);
    });

    test('speedProvider has initial value of 5.0', () {
      final speed = container.read(speedProvider);
      expect(speed, 5.0);
    });

    test('speedSliderModeProvider has initial value of true', () {
      final speedSliderMode = container.read(speedSliderModeProvider);
      expect(speedSliderMode, true);
    });

    test('temperatureProvider can be updated', () {
      // Initial value
      expect(container.read(temperatureProvider), 5.0);

      // Update value
      container.read(temperatureProvider.notifier).state = 20.0;

      // Check updated value
      expect(container.read(temperatureProvider), 20.0);
    });

    test('speedProvider can be updated', () {
      // Initial value
      expect(container.read(speedProvider), 5.0);

      // Update value
      container.read(speedProvider.notifier).state = 15.0;

      // Check updated value
      expect(container.read(speedProvider), 15.0);
    });

    test('speedSliderModeProvider can be toggled', () {
      // Initial value
      expect(container.read(speedSliderModeProvider), true);

      // Toggle value
      container.read(speedSliderModeProvider.notifier).state = false;

      // Check updated value
      expect(container.read(speedSliderModeProvider), false);
    });

    test('sliderHeightProvider calculates correct height', () {
      const containerHeight = 100.0;

      // Set temperature to 15.0 (half of max 30.0)
      container.read(temperatureProvider.notifier).state = 15.0;

      // Height should be 50.0 (half of container height)
      final height = container.read(sliderHeightProvider(containerHeight));
      expect(height, 50.0);
    });

    test('speedSliderHeightProvider calculates correct height', () {
      const containerHeight = 200.0;

      // Set speed to 30.0 (max value)
      container.read(speedProvider.notifier).state = 30.0;

      // Height should be 200.0 (full container height)
      final height = container.read(speedSliderHeightProvider(containerHeight));
      expect(height, 200.0);
    });
  });
}
