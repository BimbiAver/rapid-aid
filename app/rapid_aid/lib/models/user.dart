class Welcome {
  String nicNo;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String address;
  String mobileNo;
  String emailAddress;
  String bloodGroup;
  Guardian guardian;
  List<MedicalDetail> medicalDetails;

  Welcome({
    required this.nicNo,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.address,
    required this.mobileNo,
    required this.emailAddress,
    required this.bloodGroup,
    required this.guardian,
    required this.medicalDetails,
  });
}

class Guardian {
  String nicNo;
  String fullName;
  String address;
  String contactNo;
  String relationship;

  Guardian({
    required this.nicNo,
    required this.fullName,
    required this.address,
    required this.contactNo,
    required this.relationship,
  });
}

class MedicalDetail {
  String disease;
  String since;
  bool underTreatments;

  MedicalDetail({
    required this.disease,
    required this.since,
    required this.underTreatments,
  });
}
