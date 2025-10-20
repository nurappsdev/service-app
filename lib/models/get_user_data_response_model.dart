//
// class GetUserData {
//   final String? id;
//   final String? firstName;
//   final String? lastName;
//   final String? gender;
//   final DateTime? dateOfBirth;
//   final String? phoneNumber;
//   final String? residentialAddress;
//   final String? suburb;
//   final String? state;
//    final List<String>? languagesSpoken;
//   final String? emergencyContactFirstName;
//   final String? emergencyContactLastName;
//   final String? emergencyContactRelationship;
//   final String? emergencyContactPhoneNumber;
//   final String? email;
//   final String? role;
//   final bool? profileStatus;
//   final String? image;
//
//   GetUserData({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.dateOfBirth,
//     this.phoneNumber,
//     this.residentialAddress,
//     this.suburb,
//     this.state,
//     this.languagesSpoken,
//     this.emergencyContactFirstName,
//     this.emergencyContactLastName,
//     this.emergencyContactRelationship,
//     this.emergencyContactPhoneNumber,
//     this.email,
//     this.role,
//     this.profileStatus,
//     this.image,
//   });
//
//   factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
//     id: json["_id"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     gender: json["gender"],
//     dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
//     phoneNumber: json["phoneNumber"],
//     residentialAddress: json["residentialAddress"],
//     suburb: json["suburb"],
//     state: json["state"],
//     languagesSpoken: json["languagesSpoken"] == null ? [] : List<String>.from(json["languagesSpoken"]!.map((x) => x)),
//     emergencyContactFirstName: json["emergencyContactFirstName"],
//     emergencyContactLastName: json["emergencyContactLastName"],
//     emergencyContactRelationship: json["emergencyContactRelationship"],
//     emergencyContactPhoneNumber: json["emergencyContactPhoneNumber"],
//     email: json["email"],
//     role: json["role"],
//     profileStatus: json["profile_status"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "firstName": firstName,
//     "lastName": lastName,
//     "gender": gender,
//     "dateOfBirth": dateOfBirth?.toIso8601String(),
//     "phoneNumber": phoneNumber,
//     "residentialAddress": residentialAddress,
//     "suburb": suburb,
//     "state": state,
//     "languagesSpoken": languagesSpoken == null ? [] : List<dynamic>.from(languagesSpoken!.map((x) => x)),
//     "emergencyContactFirstName": emergencyContactFirstName,
//     "emergencyContactLastName": emergencyContactLastName,
//     "emergencyContactRelationship": emergencyContactRelationship,
//     "emergencyContactPhoneNumber": emergencyContactPhoneNumber,
//     "email": email,
//     "role": role,
//     "profile_status": profileStatus,
//     "image": image,
//   };
// }
//
// class UserData {
//   static String? id;
//   static String? firstName;
//   static String? lastName;
//   static String? gender;
//   static DateTime? dateOfBirth;
//   static String? phoneNumber;
//   static String? residentialAddress;
//   static String? suburb;
//   static String? state;
//   static List<String>? languagesSpoken;
//   static String? emergencyContactFirstName;
//   static String? emergencyContactLastName;
//   static String? emergencyContactRelationship;
//   static String? emergencyContactPhoneNumber;
//   static String? email;
//   static String? role;
//   static bool? profileStatus;
//   static String? image;
//
//   // Method to update static fields from GetUserData instance
//   static void updateUserData(GetUserData user) {
//     UserData.id = user.id;
//     UserData.firstName = user.firstName;
//     UserData.lastName = user.lastName;
//     UserData.gender = user.gender;
//     UserData.dateOfBirth = user.dateOfBirth;
//     UserData.phoneNumber = user.phoneNumber;
//     UserData.residentialAddress = user.residentialAddress;
//     UserData.suburb = user.suburb;
//     UserData.state = user.state;
//     UserData.languagesSpoken = user.languagesSpoken;
//     UserData.emergencyContactFirstName = user.emergencyContactFirstName;
//     UserData.emergencyContactLastName = user.emergencyContactLastName;
//     UserData.emergencyContactRelationship = user.emergencyContactRelationship;
//     UserData.emergencyContactPhoneNumber = user.emergencyContactPhoneNumber;
//     UserData.email = user.email;
//     UserData.role = user.role;
//     UserData.profileStatus = user.profileStatus;
//     UserData.image = user.image;
//   }
// }

class GetUserData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? residentialAddress;
  final String? suburb;
  final String? state;
  final List<String>? languagesSpoken;
  final String? emergencyContactFirstName;
  final String? emergencyContactLastName;
  final String? emergencyContactRelationship;
  final String? emergencyContactPhoneNumber;
  final String? email;
  final String? role;
  final bool? profileStatus;
  final String? image;

  GetUserData({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.residentialAddress,
    this.suburb,
    this.state,
    this.languagesSpoken,
    this.emergencyContactFirstName,
    this.emergencyContactLastName,
    this.emergencyContactRelationship,
    this.emergencyContactPhoneNumber,
    this.email,
    this.role,
    this.profileStatus,
    this.image,
  });

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    phoneNumber: json["phoneNumber"],
    residentialAddress: json["residentialAddress"],
    suburb: json["suburb"],
    state: json["state"],
    languagesSpoken: json["languagesSpoken"] == null ? [] : List<String>.from(json["languagesSpoken"]!.map((x) => x)),
    emergencyContactFirstName: json["emergencyContactFirstName"],
    emergencyContactLastName: json["emergencyContactLastName"],
    emergencyContactRelationship: json["emergencyContactRelationship"],
    emergencyContactPhoneNumber: json["emergencyContactPhoneNumber"],
    email: json["email"],
    role: json["role"],
    profileStatus: json["profile_status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "phoneNumber": phoneNumber,
    "residentialAddress": residentialAddress,
    "suburb": suburb,
    "state": state,
    "languagesSpoken": languagesSpoken == null ? [] : List<dynamic>.from(languagesSpoken!.map((x) => x)),
    "emergencyContactFirstName": emergencyContactFirstName,
    "emergencyContactLastName": emergencyContactLastName,
    "emergencyContactRelationship": emergencyContactRelationship,
    "emergencyContactPhoneNumber": emergencyContactPhoneNumber,
    "email": email,
    "role": role,
    "profile_status": profileStatus,
    "image": image,
  };

  // CopyWith method to create a new instance with updated languagesSpoken
  GetUserData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? residentialAddress,
    String? suburb,
    String? state,
    List<String>? languagesSpoken,
    String? emergencyContactFirstName,
    String? emergencyContactLastName,
    String? emergencyContactRelationship,
    String? emergencyContactPhoneNumber,
    String? email,
    String? role,
    bool? profileStatus,
    String? image,
  }) {
    return GetUserData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      residentialAddress: residentialAddress ?? this.residentialAddress,
      suburb: suburb ?? this.suburb,
      state: state ?? this.state,
      languagesSpoken: languagesSpoken ?? this.languagesSpoken,
      emergencyContactFirstName: emergencyContactFirstName ?? this.emergencyContactFirstName,
      emergencyContactLastName: emergencyContactLastName ?? this.emergencyContactLastName,
      emergencyContactRelationship: emergencyContactRelationship ?? this.emergencyContactRelationship,
      emergencyContactPhoneNumber: emergencyContactPhoneNumber ?? this.emergencyContactPhoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      profileStatus: profileStatus ?? this.profileStatus,
      image: image ?? this.image,
    );
  }
}

