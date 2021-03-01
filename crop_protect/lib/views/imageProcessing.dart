import 'package:crop_protect/model/detectedDiseaseModel.dart';
import 'package:crop_protect/repository/detectDisease.dart';
import 'package:crop_protect/repository/sendDiseaseReport.dart';
import 'package:crop_protect/widgets/loading.dart';
import 'package:crop_protect/widgets/myColorPallete.dart';
import 'package:crop_protect/widgets/sideMenu.dart';
import 'package:crop_protect/widgets/snackBarInformer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' as io;

class ImageProcessing extends StatefulWidget {
  @override
  _ImageProcessingState createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  io.File _selectedImage;
  DetectedDiseaseModel _detectedDiseaseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPallete.bg,
        title: Text("Crop Protect",
            style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 22)),
      ),
      drawer: SideMenu(),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectedImagesPreview(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton(text: "Select", function: selectImage),
                  buildButton(text: "Process", function: processImage),
                ],
              ),
              buildDisplayData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({Function function, String text}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorPallete.bg, // background
      ),
      child: Text(text,
          style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 20)),
      onPressed: function,
    );
  }

  void selectImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null)
        _selectedImage = io.File(pickedFile.path);
      else
        SnackBarInformer(context, 'No image selected.').run();
    });
  }

  void processImage() async {
    if (_selectedImage != null) {
      Loading(context).run();
      DetectedDiseaseModel _temp =
          await DetectDisease(imageFile: _selectedImage, context: context)
              .run();
      setState(() {
        if (_temp != null) _detectedDiseaseModel = _temp;
      });
      Navigator.of(context).pop();
    } else {
      SnackBarInformer(context, 'No image selected').run();
    }
  }

  Widget selectedImagesPreview() {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      height: 300,
      width: _screenWidth * 0.95,
      child: _selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                _selectedImage,
                fit: BoxFit.fill,
              ),
            )
          : Center(
              child: Text(
                "No image selected",
                style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 20),
              ),
            ),
    );
  }

  Widget buildDisplayData() {
    return _detectedDiseaseModel != null
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Disease Detected :"),
                      content(_detectedDiseaseModel.detectedDisease),
                      _detectedDiseaseModel.accuracy != "None"
                          ? content("Accuracy : " +
                              (double.parse(_detectedDiseaseModel.accuracy) *
                                      100)
                                  .toString() +
                              "%\n")
                          : Container(),
                    ],
                  ),
                ),
                _detectedDiseaseModel.accuracy != "None"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            title: heading("What is it ?"),
                            children: [
                              content(
                                  _detectedDiseaseModel.details.introduction +
                                      "\n"),
                            ],
                          ),
                          ExpansionTile(
                            title: heading("Treatment"),
                            children: [
                              content(
                                  _detectedDiseaseModel.details.cure + "\n"),
                            ],
                          ),
                          ExpansionTile(
                            title: heading("Precautions"),
                            children: [
                              content(
                                  _detectedDiseaseModel.details.precautions +
                                      "\n"),
                            ],
                          ),
                          ExpansionTile(
                            title: heading("Generally Found In"),
                            children: [
                              content(_detectedDiseaseModel.details.location +
                                  "\n"),
                            ],
                          ),
                          ExpansionTile(
                            title: heading("Medicine"),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  medicineImage(
                                      _detectedDiseaseModel.details.mediImage1),
                                  medicineImage(
                                      _detectedDiseaseModel.details.mediImage2),
                                ],
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: heading("Do you want to report?"),
                            children: [
                              content(
                                  "You can report about the disease, so that it can be used by research centers for taking appropriate steps."),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: buildButton(
                                    text: "Report",
                                    function: SendDiseaseReport(
                                            diseaseDetected:
                                                _detectedDiseaseModel
                                                    .detectedDisease,
                                            context: context)
                                        .run),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          )
        : Container();
  }

  Widget heading(String heading) {
    return Text(
      heading,
      style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 25),
    );
  }

  Widget content(String content) {
    return Text(
      content,
      style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 21),
    );
  }

  Widget medicineImage(String url) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ClipRRect(
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
