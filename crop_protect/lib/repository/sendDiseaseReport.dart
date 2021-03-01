import 'package:crop_protect/widgets/loading.dart';
import 'package:crop_protect/widgets/snackBarInformer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SendDiseaseReport {
  final String diseaseDetected;
  final BuildContext context;

  SendDiseaseReport({this.diseaseDetected, this.context});

  void run() async {
    Loading(context).run();
    final databaseReference = FirebaseDatabase.instance.reference();
    Position position = await _determinePosition();
    databaseReference.push().set({
      'dateTime': DateTime.now().toString(),
      'disease': diseaseDetected,
      'cropName': diseaseDetected.split(" ")[0],
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
    SnackBarInformer(context, "Sucessfully, report sent.").run();
    Navigator.of(context).pop();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.of(context).pop();
      SnackBarInformer(context, "Location services are disabled.").run();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      Navigator.of(context).pop();
      SnackBarInformer(context,
              'Location permissions are permantly denied, we cannot request permissions.')
          .run();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Navigator.of(context).pop();
        SnackBarInformer(context,
                'Location permissions are denied (actual value: $permission).')
            .run();
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
