import 'package:flutter/material.dart';
import '../utils.dart';

class TextWidgetValue extends StatelessWidget {
  const TextWidgetValue({super.key, required double value, required SliderValueType type}) : _value = value, _type = type;

  final double _value;
  final SliderValueType _type;

  @override
  Widget build(BuildContext context) {
    return Text(
      _type == SliderValueType.temperature ? convertTempToString(_value) : convertSpeedToString((_value / 10).toInt()),
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
