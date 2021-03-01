import 'package:crop_protect/model/diseaseDetailsModel.dart';

class DetectedDiseaseModel {
  final String accuracy;
  final String detectedDisease;
  final DiseaseDetailsModel details;

  DetectedDiseaseModel({this.accuracy, this.detectedDisease, this.details});

  factory DetectedDiseaseModel.fromJSON(Map<String, dynamic> json) {
    if (json["accuracy"] == "null")
      return DetectedDiseaseModel(
        accuracy: "None",
        detectedDisease: json["max_prob_label"],
      );
    return DetectedDiseaseModel(
      accuracy: json["accuracy"],
      details:
          DiseaseDetailsModel.fromJSON(json["details"] as Map<String, dynamic>),
      detectedDisease: json["max_prob_label"],
    );
  }
}
