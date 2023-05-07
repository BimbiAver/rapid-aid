import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? active;
  String? nicNo;
  String? firstName;
  String? lastName;
  String? gender;
  String? dob;
  String? address;
  String? mobileNo;
  String? emailAddress;
  String? bloodGroup;
  Guardian? guardian;
  List<MedicalDetail>? medicalDetails;
  String? id;

  UserModel({
    this.active,
    this.nicNo,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.address,
    this.mobileNo,
    this.emailAddress,
    this.bloodGroup,
    this.guardian,
    this.medicalDetails,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        active: json["active"],
        nicNo: json["nicNo"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dob: json["dob"],
        address: json["address"],
        mobileNo: json["mobileNo"],
        emailAddress: json["emailAddress"],
        bloodGroup: json["bloodGroup"],
        guardian: json["guardian"] == null
            ? null
            : Guardian.fromJson(json["guardian"]),
        medicalDetails: json["medicalDetails"] == null
            ? []
            : List<MedicalDetail>.from(
                json["medicalDetails"]!.map((x) => MedicalDetail.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "nicNo": nicNo,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dob": dob,
        "address": address,
        "mobileNo": mobileNo,
        "emailAddress": emailAddress,
        "bloodGroup": bloodGroup,
        "guardian": guardian?.toJson(),
        "medicalDetails": medicalDetails == null
            ? []
            : List<dynamic>.from(medicalDetails!.map((x) => x.toJson())),
        "_id": id,
      };
}

class Guardian {
  String? nicNo;
  String? fullName;
  String? address;
  String? contactNo;
  String? relationship;

  Guardian({
    this.nicNo,
    this.fullName,
    this.address,
    this.contactNo,
    this.relationship,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        nicNo: json["nicNo"],
        fullName: json["fullName"],
        address: json["address"],
        contactNo: json["contactNo"],
        relationship: json["relationship"],
      );

  Map<String, dynamic> toJson() => {
        "nicNo": nicNo,
        "fullName": fullName,
        "address": address,
        "contactNo": contactNo,
        "relationship": relationship,
      };
}

class MedicalDetail {
  String? disease;
  DateTime? since;
  bool? underTreatments;
  String? id;

  MedicalDetail({
    this.disease,
    this.since,
    this.underTreatments,
    this.id,
  });

  factory MedicalDetail.fromJson(Map<String, dynamic> json) => MedicalDetail(
        disease: json["disease"],
        since: json["since"] == null ? null : DateTime.parse(json["since"]),
        underTreatments: json["underTreatments"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "disease": disease,
        "since": since?.toIso8601String(),
        "underTreatments": underTreatments,
        "_id": id,
      };
}
