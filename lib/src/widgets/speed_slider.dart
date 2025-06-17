import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/temperature_providers.dart';
import '../utils.dart';
import 'text_widget_value.dart';

class SpeedSlider extends ConsumerStatefulWidget {
  const SpeedSlider({super.key});

  @override
  ConsumerState<SpeedSlider> createState() => _SpeedSliderState();
}

class _SpeedSliderState extends ConsumerState<SpeedSlider> {
  double _newHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final speed = ref.read(speedProvider);
      _newHeight = (speed / 30) * MediaQuery.of(context).size.height / 2;
    });
  }

  void _updateSpeed(Offset localPosition, double containerHeight) {
    final y = localPosition.dy.clamp(0.0, containerHeight);
    final newValue = 30 - (y / containerHeight) * 30;
    final value = newValue.clamp(5.0, 30.0);
    final roundedValue = value.roundToDouble();

    ref.read(speedProvider.notifier).state = roundedValue;
    setState(() {
      _newHeight = (roundedValue / 30) * containerHeight;
    });
  }

  bool _canUpdateSpeed(Offset localPosition, double containerHeight) {
    final y = localPosition.dy.clamp(0.0, containerHeight);
    final newValue = 30 - (y / containerHeight) * 30;
    final value = newValue.clamp(5.0, 30.0);
    final roundedValue = value.roundToDouble();

    return roundedValue == 5.0 || roundedValue == 10.0 || roundedValue == 20.0 || roundedValue == 30.0;
  }

  @override
  Widget build(BuildContext context) {
    final halfHeight = MediaQuery.of(context).size.height / 2;
    final halfWidth = MediaQuery.of(context).size.width / 2;
    final speed = ref.watch(speedProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidgetValue(value: speed, type: SliderValueType.speed),
        const SizedBox(height: 50),
        Center(
          child: GestureDetector(
            onPanUpdate: (details) {
              if (_canUpdateSpeed(details.localPosition, halfHeight)) {
                _updateSpeed(details.localPosition, halfHeight);
              }
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
