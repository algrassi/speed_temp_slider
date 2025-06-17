import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Calculation Tests', () {
    // Test the color calculation logic directly
    Color temperatureToColor(double temp) {
      return Color.lerp(const Color.fromARGB(255, 125, 139, 167), const Color.fromARGB(255, 255, 98, 0), temp / 30)!;
    }

    test('temperatureToColor calculation for temperature 5.0', () {
      const temperature = 5.0;
      final color = temperatureToColor(temperature);

      // Calculate expected color manually
      const coolColor = Color.fromARGB(255, 125, 139, 167);
      const warmColor = Color.fromARGB(255, 255, 98, 0);
      const lerpFactor = temperature / 30; // 0.1667

      final expectedRed = (coolColor.red + (warmColor.red - coolColor.red) * lerpFactor).round();
      final expectedGreen = (coolColor.green + (warmColor.green - coolColor.green) * lerpFactor).round();
      final expectedBlue = (coolColor.blue + (warmColor.blue - coolColor.blue) * lerpFactor).round();

      expect(color.red, expectedRed);
      expect(color.green, expectedGreen);
      expect(color.blue, expectedBlue);
      expect(color.alpha, 255);
    });

    test('temperatureToColor calculation for temperature 0.0', () {
      const temperature = 0.0;
      final color = temperatureToColor(temperature);

      // Should be the cool color
      const expectedColor = Color.fromARGB(255, 125, 139, 167);
      expect(color, expectedColor);
    });

    test('temperatureToColor calculation for temperature 30.0', () {
      const temperature = 30.0;
      final color = temperatureToColor(temperature);

      // Should be the warm color
      const expectedColor = Color.fromARGB(255, 255, 98, 0);
      expect(color, expectedColor);
    });

    test('temperatureToColor calculation for temperature 15.0', () {
      const temperature = 15.0;
      final color = temperatureToColor(temperature);

      // Should be halfway between cool and warm
      const coolColor = Color.fromARGB(255, 125, 139, 167);
      const warmColor = Color.fromARGB(255, 255, 98, 0);
      final expectedColor = Color.lerp(coolColor, warmColor, 0.5)!;

      expect(color, expectedColor);
    });

    test('Color lerp factor calculation', () {
      expect(5.0 / 30, closeTo(0.1667, 0.001));
      expect(15.0 / 30, 0.5);
      expect(30.0 / 30, 1.0);
      expect(0.0 / 30, 0.0);
    });
  });
}
