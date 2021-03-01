import 'package:flutter/material.dart';

class Loading {
  final BuildContext context;

  Loading(this.context);

  Future<void> run() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Processing",
                style: TextStyle(
                  fontFamily: "PoppinsMedium",
                  fontSize: 22,
                ),
              ),
              CircularProgressIndicator()
            ],
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
        );
      },
    );
  }
}
