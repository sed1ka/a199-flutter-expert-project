import 'package:flutter/material.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

extension ContextExtensions on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showAlertDialog(String message) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
