import 'package:flutter/material.dart';

class SidePanelViewModel extends ChangeNotifier {

  SidePanelViewModel();

  bool _isPanelOpen = false;

  bool get isPanelOpen => _isPanelOpen;

  Future<void> togglePanelOpen() async {
    _isPanelOpen = !_isPanelOpen;

    notifyListeners();
  }
}