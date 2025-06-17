import 'package:flutter_test/flutter_test.dart';
import 'package:speed_temp_slider/src/utils.dart';

void main() {
  group('Utility Functions Tests', () {
    group('convertTempToString', () {
      test('returns OFF for temperature <= 5.0', () {
        expect(convertTempToString(5.0), 'OFF');
        expect(convertTempToString(4.0), 'OFF');
        expect(convertTempToString(0.0), 'OFF');
      });

      test('returns formatted temperature for temperature > 5.0', () {
        expect(convertTempToString(10.0), '10.0 °C');
        expect(convertTempToString(15.5), '15.5 °C');
        expect(convertTempToString(30.0), '30.0 °C');
      });
    });

    group('convertSpeedToString', () {
      test('returns SLEEP for speed 0', () {
        expect(convertSpeedToString(0), 'SLEEP');
      });

      test('returns Vel1 for speed 1', () {
        expect(convertSpeedToString(1), 'Vel1');
      });

      test('returns Vel2 for speed 2', () {
        expect(convertSpeedToString(2), 'Vel2');
      });

      test('returns Vel3 for speed 3', () {
        expect(convertSpeedToString(3), 'Vel3');
      });

      test('returns BOOST for speed 4', () {
        expect(convertSpeedToString(4), 'BOOST');
      });

      test('returns SLEEP for unknown speed', () {
        expect(convertSpeedToString(5), 'SLEEP');
        expect(convertSpeedToString(-1), 'SLEEP');
      });
    });
  });

  group('SpeedValueExtension Tests', () {
    test('returns correct string values', () {
      expect(SpeedValueType.sleep.speed, 'SLEEP');
      expect(SpeedValueType.vel1.speed, 'Vel1');
      expect(SpeedValueType.vel2.speed, 'Vel2');
      expect(SpeedValueType.vel3.speed, 'Vel3');
      expect(SpeedValueType.boost.speed, 'BOOST');
    });
  });
}
