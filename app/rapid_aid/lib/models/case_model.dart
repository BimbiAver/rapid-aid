import 'dart:convert';

CaseModel caseModelFromJson(String str) => CaseModel.fromJson(json.decode(str));

String caseModelToJson(CaseModel data) => json.encode(data.toJson());

class CaseModel {
  String? dateTime;
  String? user;
  String? status;
  String? situation;
  Departments? departments;
  String? details;
  String? location;
  List<String>? images;
  String? id;

  CaseModel({
    this.dateTime,
    this.user,
    this.status,
    this.situation,
    this.departments,
    this.details,
    this.location,
    this.images,
    this.id,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
        dateTime: json["dateTime"],
        user: json["user"],
        status: json["status"],
        situation: json["situation"],
        departments: json["departments"] == null
            ? null
            : Departments.fromJson(json["departments"]),
        details: json["details"],
        location: json["location"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "user": user,
        "status": status,
        "situation": situation,
        "departments": departments?.toJson(),
        "details": details,
        "location": location,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}

class Departments {
  Department? police;
  Department? hospital;
  Department? fireBrigade;
  Department? dmc;
  Department? mwca;

  Departments({
    this.police,
    this.hospital,
    this.fireBrigade,
    this.dmc,
    this.mwca,
  });

  factory Departments.fromJson(Map<String, dynamic> json) => Departments(
        police:
            json["police"] == null ? null : Department.fromJson(json["police"]),
        hospital: json["hospital"] == null
            ? null
            : Department.fromJson(json["hospital"]),
        fireBrigade: json["fireBrigade"] == null
            ? null
            : Department.fromJson(json["fireBrigade"]),
        dmc: json["dmc"] == null ? null : Department.fromJson(json["dmc"]),
        mwca: json["mwca"] == null ? null : Department.fromJson(json["mwca"]),
      );

  Map<String, dynamic> toJson() => {
        "police": police?.toJson(),
        "hospital": hospital?.toJson(),
        "fireBrigade": fireBrigade?.toJson(),
        "dmc": dmc?.toJson(),
        "mwca": mwca?.toJson(),
      };
}

class Department {
  bool? assign;
  String? status;
  String? station;

  Department({
    this.assign,
    this.status,
    this.station,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        assign: json["assign"],
        status: json["status"],
        station: json["station"],
      );

  Map<String, dynamic> toJson() => {
        "assign": assign,
        "status": status,
        "station": station,
      };
}
