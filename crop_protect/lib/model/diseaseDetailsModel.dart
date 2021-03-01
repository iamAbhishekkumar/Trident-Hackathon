class DiseaseDetailsModel {
  final String cure;
  final String mediImage1;
  final String mediImage2;
  final String introduction;
  final String location;
  final String precautions;

  DiseaseDetailsModel(
      {this.cure,
      this.mediImage1,
      this.mediImage2,
      this.introduction,
      this.location,
      this.precautions});

  factory DiseaseDetailsModel.fromJSON(Map<String, dynamic> json) {
    return DiseaseDetailsModel(
      cure: json["cure"],
      introduction: json["introduction"],
      location: json["location"],
      mediImage1: json["image1"],
      mediImage2: json["image2"],
      precautions: json["precautions"],
    );
  }
}
