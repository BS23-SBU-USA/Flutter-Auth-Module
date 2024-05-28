import 'package:flutter/widgets.dart';

class TextEditingControllersListenable extends ChangeNotifier {
  final List<TextEditingController> controllers;

  TextEditingControllersListenable({
    required this.controllers,
  }) {
    for (var controller in controllers) {
      controller.addListener(_onControllerChanged);
    }
  }

  bool get areNotEmpty =>
      controllers.any((controller) => controller.text.isEmpty);

  void _onControllerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.removeListener(_onControllerChanged);
    }
    super.dispose();
  }
}
