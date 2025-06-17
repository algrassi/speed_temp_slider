enum SliderValueType { temperature, speed }

enum SpeedValueType { sleep, vel1, vel2, vel3, boost }

extension SpeedValueExtension on SpeedValueType {
  String get speed {
    switch (this) {
      case SpeedValueType.sleep:
        return 'SLEEP';
      case SpeedValueType.vel1:
        return 'Vel1';
      case SpeedValueType.vel2:
        return 'Vel2';
      case SpeedValueType.vel3:
        return 'Vel3';
      case SpeedValueType.boost:
        return 'BOOST';
    }
  }
}

String convertTempToString(double temp) {
  return temp <= 5.0 ? 'OFF' : '${temp.toStringAsFixed(1)} °C';
}

String convertSpeedToString(int speed) {
  switch (speed) {
    case 0:
      return SpeedValueType.sleep.speed;
    case 1:
      return SpeedValueType.vel1.speed;
    case 2:
      return SpeedValueType.vel2.speed;
    case 3:
      return SpeedValueType.vel3.speed;
    case 4:
      return SpeedValueType.boost.speed;
    default:
      return 'SLEEP';
  }
}
