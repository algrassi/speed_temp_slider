import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/temperature_providers.dart';
import 'temperature_slider.dart';
import 'speed_slider.dart';

class SliderBody extends ConsumerWidget {
  const SliderBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedSlid = ref.watch(speedSliderModeProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        speedSlid ? const TemperatureSlider() : const SpeedSlider(),
        ElevatedButton(
          onPressed: () {
            ref.read(speedSliderModeProvider.notifier).state = !speedSlid;
          },
          child: Text(speedSlid ? 'SPEED SLIDER' : 'TEMPERATURE SLIDER'),
        ),
      ],
    );
  }
}
