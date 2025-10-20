
import 'dart:convert';

class Document {
  final String document;
  final String expiryDate;
  final String type;
  final String? publishDate;

  Document({
    required this.document,
    required this.expiryDate,
    required this.type,
    this.publishDate,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      document: json['document'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      type: json['type'] ?? '',
      publishDate: json['publishDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'expiryDate': expiryDate,
      'type': type,
      'publishDate': publishDate,
    };
  }
}

class ABN {
  final String isVerifyed;
  final String? adminNote;
  final String abnNumber;
  final String businessName;
  final bool gstRegistered;

  ABN({
    required this.isVerifyed,
    this.adminNote,
    required this.abnNumber,
    required this.businessName,
    required this.gstRegistered,
  });

  factory ABN.fromJson(Map<String, dynamic> json) {
    return ABN(
      isVerifyed: json['isVerifyed'] ?? '',
      adminNote: json['adminNote'],
      abnNumber: json['abnNumber'] ?? '',
      businessName: json['businessName'] ?? '',
      gstRegistered: json['gstRegistered'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isVerifyed': isVerifyed,
      'adminNote': adminNote,
      'abnNumber': abnNumber,
      'businessName': businessName,
      'gstRegistered': gstRegistered,
    };
  }
}

class BankDetails {
  final String isVerifyed;
  final String? adminNote;
  final String bsbNumber;
  final String accountNumber;

  BankDetails({
    required this.isVerifyed,
    this.adminNote,
    required this.bsbNumber,
    required this.accountNumber,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      isVerifyed: json['isVerifyed'] ?? '',
      adminNote: json['adminNote'],
      bsbNumber: json['bsbNumber'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isVerifyed': isVerifyed,
      'adminNote': adminNote,
      'bsbNumber': bsbNumber,
      'accountNumber': accountNumber,
    };
  }
}

class UserData {
  final String id;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final ABN abn;
  final BankDetails bankDetails;
  final Document passport;
  final Document drivingLicense;
  final Document carInsuranceCertificate;
  final Document workingWithChildren;
  final List<Document> firstAid;
  final List<Document> policeCheck;
  final List<Document> qualification;
  final List<Document> vaccination;

  UserData({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.abn,
    required this.bankDetails,
    required this.passport,
    required this.drivingLicense,
    required this.carInsuranceCertificate,
    required this.workingWithChildren,
    required this.firstAid,
    required this.policeCheck,
    required this.qualification,
    required this.vaccination,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      abn: ABN.fromJson(json['abn']),
      bankDetails: BankDetails.fromJson(json['bankDetails']),
      passport: Document.fromJson(json['passport']),
      drivingLicense: Document.fromJson(json['drivingLicense']),
      carInsuranceCertificate: Document.fromJson(json['carInsuranceCertificate']),
      workingWithChildren: Document.fromJson(json['workingWithChildren']),
      firstAid: (json['firstAid'] as List)
          .map((item) => Document.fromJson(item))
          .toList(),
      policeCheck: (json['policeCheck'] as List)
          .map((item) => Document.fromJson(item))
          .toList(),
      qualification: (json['qualification'] as List)
          .map((item) => Document.fromJson(item))
          .toList(),
      vaccination: (json['vaccination'] as List)
          .map((item) => Document.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'abn': abn.toJson(),
      'bankDetails': bankDetails.toJson(),
      'passport': passport.toJson(),
      'drivingLicense': drivingLicense.toJson(),
      'carInsuranceCertificate': carInsuranceCertificate.toJson(),
      'workingWithChildren': workingWithChildren.toJson(),
      'firstAid': firstAid.map((item) => item.toJson()).toList(),
      'policeCheck': policeCheck.map((item) => item.toJson()).toList(),
      'qualification': qualification.map((item) => item.toJson()).toList(),
      'vaccination': vaccination.map((item) => item.toJson()).toList(),
    };
  }
}
