# 🌡️ Temperature Slider

A beautiful and intuitive temperature and speed slider plugin for Flutter with smooth animations and customizable design.

[![pub package](https://img.shields.io/pub/v/speed_temp_slider.svg)](https://pub.dev/packages/speed_temp_slider)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🌡️ **Temperature Slider**: Smooth temperature control from 5°C to 30°C
- 🚀 **Speed Slider**: Discrete speed levels (Sleep, Vel1, Vel2, Vel3, Boost)
- 🎨 **Dynamic Background**: Color changes based on temperature
- 📱 **Responsive Design**: Adapts to different screen sizes
- ⚡ **Smooth Animations**: Fluid transitions and interactions
- 🔄 **Easy Toggle**: Switch between temperature and speed modes
- 📦 **Self-Contained**: No external setup required
- 🎯 **Zero Configuration**: Works out of the box

## 📱 Preview

The plugin provides two slider modes:
- **Temperature Mode**: Continuous temperature control with visual feedback
- **Speed Mode**: Discrete speed levels with snapping behavior

## 🚀 Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  speed_temp_slider: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TemperatureController(),
      ),
    );
  }
}
```

That's it! The plugin is completely self-contained and requires no additional setup.

## 📖 Advanced Usage

### Accessing Current Values

If you need to access the current temperature or speed values:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_temp_slider/speed_temp_slider.dart';

class MyAdvancedApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: TemperatureController()),
            // Access current values (requires exposing providers)
            Consumer(
              builder: (context, ref, child) {
                // Note: Providers would need to be exported for this to work
                return Text('Current temperature: ${ref.watch(temperatureProvider)}°C');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### Custom Integration

The plugin can be easily integrated into existing apps:

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Climate Control')),
      body: Column(
        children: [
          Text('Room Temperature Control', style: Theme.of(context).textTheme.headlineMedium),
          Expanded(
            child: TemperatureController(),
          ),
          ElevatedButton(
            onPressed: () {
              // Your custom actions
            },
            child: Text('Apply Settings'),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 Customization

The plugin uses a responsive design that adapts to your app's theme and screen size. The background color automatically transitions from cool blue to warm orange based on the temperature setting.

### Slider Behavior

- **Temperature Slider**: Continuous values from 5.0°C to 30.0°C
- **Speed Slider**: Discrete values that snap to predefined levels
  - Sleep (5°C equivalent)
  - Vel1 (10°C equivalent)  
  - Vel2 (20°C equivalent)
  - Vel3 (25°C equivalent)
  - Boost (30°C equivalent)

## 🏗️ Architecture

This plugin uses:
- **Flutter Riverpod** for state management
- **Self-contained ProviderScope** for isolation
- **Responsive design** principles
- **Smooth animations** with `AnimatedContainer`

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/algrassi/speed_temp_slider.git`
3. Create a feature branch: `git checkout -b feature/amazing-feature`
4. Make your changes
5. Add tests if applicable
6. Commit your changes: `git commit -m 'Add amazing feature'`
7. Push to the branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

## 📋 Requirements

- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0 <4.0.0`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Issues and Feedback

Please file feature requests and bugs at the [issue tracker](https://github.com/algrassi/speed_temp_slider/issues).

## 📚 API Documentation

For detailed API documentation, visit [pub.dev documentation](https://pub.dev/documentation/speed_temp_slider/latest/).

## 🔖 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes in each version.

## ❤️ Support

If you find this plugin helpful, please give it a ⭐ on [GitHub](https://github.com/algrassi/speed_temp_slider) and a 👍 on [pub.dev](https://pub.dev/packages/speed_temp_slider)!

---

Made with ❤️ by [Alessandro Grassi](https://github.com/algrassi)