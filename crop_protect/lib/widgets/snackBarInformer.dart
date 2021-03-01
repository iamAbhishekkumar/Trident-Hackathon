import 'package:flutter/material.dart';

class SnackBarInformer {
  final BuildContext context;
  final String message;

  SnackBarInformer(this.context, this.message);

  void run() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
