
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String? deviceId;

  void setDeviceId(String id) {
    deviceId = id;
    notifyListeners();
  }
}