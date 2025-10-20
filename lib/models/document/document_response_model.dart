
class DocumentResponseModel {
  final Abn? abn;
  final BankDetails? bankDetails;
  final Passport? passport;
  final DrivingLicense? drivingLicense;
  final CarInsuranceCertificate? carInsuranceCertificate;
  final Passport? workingWithChildren;
  final String? id;
  final String? userId;
  final int? v;
  final DateTime? createdAt;
  final List<FirstAid>? firstAid;
  final List<PoliceChecks>? policeCheck;
  final List<QualificationsData>? qualification;
  final DateTime? updatedAt;
  final List<VaccinationData>? vaccination;

  DocumentResponseModel({
    this.abn,
    this.bankDetails,
    this.passport,
    this.drivingLicense,
    this.carInsuranceCertificate,
    this.workingWithChildren,
    this.id,
    this.userId,
    this.v,
    this.createdAt,
    this.firstAid,
    this.policeCheck,
    this.qualification,
    this.updatedAt,
    this.vaccination,
  });

  factory DocumentResponseModel.fromJson(Map<String, dynamic> json) => DocumentResponseModel(
    abn: json["abn"] == null ? null : Abn.fromJson(json["abn"]),
    bankDetails: json["bankDetails"] == null ? null : BankDetails.fromJson(json["bankDetails"]),
    passport: json["passport"] == null ? null : Passport.fromJson(json["passport"]),
    drivingLicense: json["drivingLicense"] == null ? null : DrivingLicense.fromJson(json["drivingLicense"]),
    carInsuranceCertificate: json["carInsuranceCertificate"] == null ? null : CarInsuranceCertificate.fromJson(json["carInsuranceCertificate"]),
    workingWithChildren: json["workingWithChildren"] == null ? null : Passport.fromJson(json["workingWithChildren"]),
    id: json["_id"],
    userId: json["userId"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    firstAid: json["firstAid"] == null ? [] : List<FirstAid>.from(json["firstAid"]!.map((x) => FirstAid.fromJson(x))),
    policeCheck: json["checks"] == null ? [] : List<PoliceChecks>.from(json["checks"]!.map((x) => PoliceChecks.fromJson(x))),
    qualification: json["qualification"] == null ? [] : List<QualificationsData>.from(json["qualification"]!.map((x) => QualificationsData.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    vaccination: json["vaccination"] == null ? [] : List<VaccinationData>.from(json["vaccination"]!.map((x) => VaccinationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "abn": abn?.toJson(),
    "bankDetails": bankDetails?.toJson(),
    "passport": passport?.toJson(),
    "drivingLicense": drivingLicense?.toJson(),
    "carInsuranceCertificate": carInsuranceCertificate?.toJson(),
    "workingWithChildren": workingWithChildren?.toJson(),
    "_id": id,
    "userId": userId,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "firstAid": firstAid == null ? [] : List<dynamic>.from(firstAid!.map((x) => x.toJson())),
    "policeCheck": policeCheck == null ? [] : List<dynamic>.from(policeCheck!.map((x) => x.toJson())),
    "qualification": qualification == null ? [] : List<dynamic>.from(qualification!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
    "vaccination": vaccination == null ? [] : List<dynamic>.from(vaccination!.map((x) => x.toJson())),
  };
}

class Abn {
  final String? isVerifyed;
  final dynamic adminNote;
  final String? abnNumber;
  final String? businessName;
  final bool? gstRegistered;

  Abn({
    this.isVerifyed,
    this.adminNote,
    this.abnNumber,
    this.businessName,
    this.gstRegistered,
  });

  factory Abn.fromJson(Map<String, dynamic> json) => Abn(
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    abnNumber: json["abnNumber"],
    businessName: json["businessName"],
    gstRegistered: json["gstRegistered"],
  );

  Map<String, dynamic> toJson() => {
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "abnNumber": abnNumber,
    "businessName": businessName,
    "gstRegistered": gstRegistered,
  };
}

class BankDetails {
  final String? isVerifyed;
  final dynamic adminNote;
  final String? bsbNumber;
  final String? accountNumber;

  BankDetails({
    this.isVerifyed,
    this.adminNote,
    this.bsbNumber,
    this.accountNumber,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    bsbNumber: json["bsbNumber"],
    accountNumber: json["accountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "bsbNumber": bsbNumber,
    "accountNumber": accountNumber,
  };
}

class CarInsuranceCertificate {
  String isVerifyed;
  final dynamic adminNote;
  final String? certificate;
  final DateTime? expiryDate;
  final String? type;

  CarInsuranceCertificate({
    required this.isVerifyed,
    this.adminNote,
    this.certificate,
    this.expiryDate,
    this.type,
  });

  factory CarInsuranceCertificate.fromJson(Map<String, dynamic> json) => CarInsuranceCertificate(
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    certificate: json["certificate"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "certificate": certificate,
    "expiryDate": expiryDate?.toIso8601String(),
    "type": type,
  };
}

class DrivingLicense {
  final String? isVerifyed;
  final dynamic adminNote;
  final String? frontDocument;
  final String? backDocument;
  final DateTime? expiryDate;

  DrivingLicense({
    this.isVerifyed,
    this.adminNote,
    this.frontDocument,
    this.backDocument,
    this.expiryDate,
  });

  factory DrivingLicense.fromJson(Map<String, dynamic> json) => DrivingLicense(
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    frontDocument: json["frontDocument"],
    backDocument: json["backDocument"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
  );

  Map<String, dynamic> toJson() => {
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "frontDocument": frontDocument,
    "backDocument": backDocument,
    "expiryDate": expiryDate?.toIso8601String(),
  };
}

class Passport {
   String isVerifyed;
  final dynamic adminNote;
  final DateTime? expiryDate;
  final String? document;

  Passport({
    required this.isVerifyed,
    this.adminNote,
    this.expiryDate,
    this.document,
  });

  factory Passport.fromJson(Map<String, dynamic> json) => Passport(
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "expiryDate": expiryDate?.toIso8601String(),
    "document": document,
  };
}
class FirstAid {
  final String? document;
  final DateTime? expiryDate;
   var  type;
  final String? isVerifyed;
  final dynamic adminNote;
  final String? id;



  FirstAid({
    this.document,
    this.expiryDate,
    this.type,
    this.isVerifyed,
    this.adminNote,
    this.id,

  });

  factory FirstAid.fromJson(Map<String, dynamic> json) => FirstAid(
    document: json["document"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    type: json["type"],
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    id: json["_id"],

  );

  Map<String, dynamic> toJson() => {
    "document": document,
    "expiryDate": expiryDate?.toIso8601String(),
    "type": type,
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "_id": id,
  };
}

class PoliceChecks {
  final String? document;
  var  type;
  final String? isVerifyed;
  final dynamic adminNote;
  final String? id;
  final DateTime? publishDate;
  final String? certificate;

  PoliceChecks({
    this.document,
    this.type,
    this.isVerifyed,
    this.adminNote,
    this.id,
    this.publishDate,
    this.certificate,
  });

  factory PoliceChecks.fromJson(Map<String, dynamic> json) => PoliceChecks(
    document: json["document"],
    type: json["type"],
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    id: json["_id"],
    publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
    certificate: json["certificate"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
    "type": type,
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "_id": id,
    "publishDate": publishDate?.toIso8601String(),
    "certificate": certificate,
  };
}

class QualificationsData {
  final DateTime? expiryDate;
  var type;
  final String? isVerifyed;
  final dynamic adminNote;
  final String? id;
  final String? certificate;

  QualificationsData({

    this.expiryDate,
    this.type,
    this.isVerifyed,
    this.adminNote,
    this.id,
    this.certificate,
  });

  factory QualificationsData.fromJson(Map<String, dynamic> json) => QualificationsData(

    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    type: json["type"],
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    id: json["_id"],
    certificate: json["certificate"],
  );

  Map<String, dynamic> toJson() => {
    "expiryDate": expiryDate?.toIso8601String(),
    "type": type,
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "_id": id,
    "certificate": certificate,
  };
}

class VaccinationData {
  final DateTime? publishDate;
  var  type;
  final String? isVerifyed;
  final dynamic adminNote;
  final String? id;
  final String? certificate;

  VaccinationData({

    this.publishDate,
    this.type,
    this.isVerifyed,
    this.adminNote,
    this.id,
    this.certificate,
  });

  factory VaccinationData.fromJson(Map<String, dynamic> json) => VaccinationData(

    publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
    type: json["type"],
    isVerifyed: json["isVerifyed"],
    adminNote: json["adminNote"],
    id: json["_id"],
    certificate: json["certificate"],
  );

  Map<String, dynamic> toJson() => {
    "publishDate": publishDate?.toIso8601String(),
    "type": type,
    "isVerifyed": isVerifyed,
    "adminNote": adminNote,
    "_id": id,
    "certificate": certificate,
  };
}

