import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/temperature_providers.dart';
import '../utils.dart';
import 'text_widget_value.dart';

class TemperatureSlider extends ConsumerStatefulWidget {
  const TemperatureSlider({super.key});

  @override
  ConsumerState<TemperatureSlider> createState() => _TemperatureSliderState();
}

class _TemperatureSliderState extends ConsumerState<TemperatureSlider> {
  double _newHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final temperature = ref.read(temperatureProvider);
      _newHeight = (temperature / 30) * MediaQuery.of(context).size.height / 2;
    });
  }

  void _updateTemperature(Offset localPosition, double containerHeight) {
    final y = localPosition.dy.clamp(0.0, containerHeight);
    final newTemp = 30 - (y / containerHeight) * 30;
    final clampedTemp = newTemp.clamp(5.0, 30.0);

    ref.read(temperatureProvider.notifier).state = clampedTemp;
    setState(() {
      _newHeight = (clampedTemp / 30) * containerHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final halfHeight = MediaQuery.of(context).size.height / 2;
    final halfWidth = MediaQuery.of(context).size.width / 2;
    final temperature = ref.watch(temperatureProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidgetValue(value: temperature, type: SliderValueType.temperature),
        const SizedBox(height: 50),
        Center(
          child: GestureDetector(
            onPanUpdate: (details) {
              _updateTemperature(details.localPosition, halfHeight);
            },
            child: Container(
              height: halfHeight,
              width: halfWidth,
              decoration: BoxDecoration(color: const Color.fromARGB(56, 255, 255, 255), borderRadius: BorderRadius.circular(60)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        height: _newHeight,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
