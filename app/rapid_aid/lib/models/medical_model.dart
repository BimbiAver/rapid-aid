import 'dart:convert';

List<MedicalModel> medicalModelListFromJson(String str) =>
    List<MedicalModel>.from(
        json.decode(str).map((x) => MedicalModel.fromJson(x)));

String medicalModelListToJson(List<MedicalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// -------------------------------

MedicalModel medicalModelFromJson(String str) =>
    MedicalModel.fromJson(json.decode(str));

String medicalModelToJson(MedicalModel data) => json.encode(data.toJson());

class MedicalModel {
  String? disease;
  String? since;
  bool? underTreatments;
  String? id;

  MedicalModel({
    this.disease,
    this.since,
    this.underTreatments,
    this.id,
  });

  factory MedicalModel.fromJson(Map<String, dynamic> json) => MedicalModel(
        disease: json["disease"],
        since: json["since"],
        underTreatments: json["underTreatments"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "disease": disease,
        "since": since,
        "underTreatments": underTreatments,
      };
}
