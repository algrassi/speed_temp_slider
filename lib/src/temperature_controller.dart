import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/slider_body.dart';
import 'providers/temperature_providers.dart';

class TemperatureController extends StatelessWidget {
  const TemperatureController({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _TemperatureControllerContent());
  }
}

class _TemperatureControllerContent extends ConsumerWidget {
  const _TemperatureControllerContent();

  Color temperatureToColor(double temp) {
    return Color.lerp(const Color.fromARGB(255, 125, 139, 167), const Color.fromARGB(255, 255, 98, 0), temp / 30)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temperature = ref.watch(temperatureProvider);

    return Scaffold(backgroundColor: temperatureToColor(temperature), body: const SliderBody());
  }
}
