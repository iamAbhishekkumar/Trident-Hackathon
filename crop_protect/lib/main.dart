import 'package:crop_protect/widgets/snackBarInformer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/imageProcessing.dart';

// First you need to connect this app to your desired firebase account and to get the feature of database and that database feature.


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            SnackBarInformer(context, "Something went wrong");
          }
          return ImageProcessing();
        },
      ),
    );
  }
}
