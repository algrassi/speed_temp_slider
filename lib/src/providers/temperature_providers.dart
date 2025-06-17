import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the current temperature value (5.0 to 30.0)
final temperatureProvider = StateProvider<double>((ref) => 5.0);

/// Provider for the current speed value (5.0 to 30.0, but used differently)
final speedProvider = StateProvider<double>((ref) => 5.0);

/// Provider to toggle between temperature and speed slider modes
final speedSliderModeProvider = StateProvider<bool>((ref) => true);

/// Provider for the visual height of the slider based on temperature
final sliderHeightProvider = Provider.family<double, double>((ref, containerHeight) {
  final temperature = ref.watch(temperatureProvider);
  return (temperature / 30) * containerHeight;
});

/// Provider for the visual height of the speed slider
final speedSliderHeightProvider = Provider.family<double, double>((ref, containerHeight) {
  final speed = ref.watch(speedProvider);
  return (speed / 30) * containerHeight;
});
