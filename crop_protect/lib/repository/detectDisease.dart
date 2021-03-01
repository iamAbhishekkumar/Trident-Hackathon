import 'dart:convert';

import 'package:crop_protect/model/detectedDiseaseModel.dart';
import 'package:crop_protect/widgets/snackBarInformer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class DetectDisease {
  final io.File imageFile;
  final BuildContext context;
  DetectDisease({this.context, this.imageFile});

  Future<DetectedDiseaseModel> run() async {
    DetectedDiseaseModel diseaseModel;
    String url = "https://croprotect.herokuapp.com/";
    try {
      var stream = new http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(http.MultipartFile('file', stream, length, filename: "myImage"));
      http.StreamedResponse r = await request.send();
      print(r.statusCode);
      if (r.statusCode == 200) {
        var parsedResponse =
            jsonDecode(await r.stream.transform(utf8.decoder).join());
        Map _json = parsedResponse as Map<String, dynamic>;
        diseaseModel = DetectedDiseaseModel.fromJSON(_json);
      }
      if (r.statusCode == 503) {
        SnackBarInformer(context, "Server Problem. Try Again.").run();
      }
    } catch (e) {
      print(e.toString());
    }
    return diseaseModel;
  }
}
