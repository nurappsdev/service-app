

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/models.dart';
import '../../services/client_service.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';
import '../../views/screens/screens.dart';
import 'package:http/http.dart' as http;

class ProfileSetupController extends GetxController{

  @override
  void onInit(){
    super.onInit();
    getUserData();
    getAboutData(isAbouts: true,isTerms: true);
    fetchDocumentResponse();
  }

///------------passport-------------

  String? pickedPassportFilePath;
///------------Drive Licence-----------
  String? driveFontFilePath;
  String? driveBackFilePath;

///------------Police Check------------
  String? policeCheckFilePath;
  List<DocItem> policeCheckLocalList = [];
  List<String> policeCheckDropdown = [
    "NDIS Worker Check",
    "Police Check",
  ];


///------------car insurance-------------
  String? pickedCarFilePath;
  String? selectedCarInsDropdown;
  List<String> carInsDropdown = ["Comprehensive", "Third Party"];



  ///===========Qualification=======================
  String? pickedQualificationFilePath;
  List<DocItem> qualificationLocalList = [];
  List<String> qualificationDropdown = [
    "Assistant in Nursing (AIN)",
    "Certificate 3 Aged Care",
    "Certificate 3 Community Services",
    "Certificate 3 in Disabilities",
    "Certificate 3 Individual Support",
    "Certificate 3 in Home and Community Care",
    "Certificate 4 Aged Care",
    "Certificate 4 Community Services",
    "Certificate 4 in Disabilities",
    "Certificate 4 Individual Support",
    "Certificate 4 in Home and Community Care",
    "Degree in Allied Health",
    "Degree in Nursing",
    "Degree in Psychology",
    "Degree in Social Work",
    "Enrolled Nurse",
    "Registered Nurse"
  ];
///===========Qualification=======================


  ///===========AidCPR=======================
  String? pickedAidFilePath;
  List<DocItem> aidCprLocalList = [];
  List<String> aidCprDropdown = [
    "Assistant in Nursing (AIN)",
    "First Aid (HLTAID011)",
    "CPR (HLTAID009)",
    "First Aid + CPR Combined",
    "Basic Emergency Life Support (HLTAID010)",
    "Advanced First Aid (HLTAID014)",
    "Advanced Resuscitation (HLTAID015)",
    "Mental Health First Aid",
    "Remote Area First Aid",
    "Childcare First Aid (HLTAID012)",
    "Occupational First Aid (HLTSS00068)",
    "First Aid (Non-accredited)",
    "CPR (Non-accredited)"
  ];
///===========AidCPR=======================
  String? pickedWorkChildFilePath;


  ///===========vaccin=======================
  String? pickedVaccinationFilePath;
  List<DocItem> vaccinationLocalList = [];
  List<String> vaccinationDropdown = [
    "Assistant in Nursing (AIN)",
    "COVID-19 Vaccination",
    "COVID-19 Vaccination Booster 1",
    "COVID-19 Vaccination Booster 2",
    "COVID-19 Vaccine Exempt",
    "Flu Vaccination",
    "Flu Vaccine Exempt"
  ];
///===========vaccin=======================



///===========Working with child=======================

///===========Working with child=======================



RxBool isGSTCheck = false.obs;
var isUploadDoc = false.obs;
  Future<void> uploadDocuments({
    required String? passportExpiry,
    required String? passportFilePath,

    required String? driveExpiry,
    required String? driveFrontPath,
    required String? driveBackPath,

    required List<DocItem> policeChecks,
     String? carInsExpiry,
     String? carInsFilePath,
     String? carInsDropdown,

     required List<DocItem> qualificationLists,
     required List<DocItem> firstAidCPR,

     required String? workingWithChildrenExpiry,
      String? workingWithChildrenFilePath,


    required List<DocItem> vaccinations,

     bool? gstRegistered,
     String? businessName,
     String? abnNumber,

     String? bsbNumber,
     String? accountNumber,


  }) async {

    final uri = Uri.parse('${ApiConstants.baseUrl}/document/upload');

    // Build police check list
    List<Map<String, dynamic>> policeCheckList = policeChecks.map((doc) {
      return {
        "document":  doc.pickedFilePath != null && doc.pickedFilePath!.isNotEmpty
            ? "/images/${File(doc.pickedFilePath.toString()).path.split('/').last}":"",
        "publishDate": doc.policeDateController.text,
        "type": doc.selectedDropdownData ?? "",
      };
    }).toList();

    // Build police Qualification
    List<Map<String, dynamic>> qualificationList = qualificationLists.map((doc) {
      return {
        "certificate":  doc.pickedFilePath != null && doc.pickedFilePath!.isNotEmpty
            ? "/images/${File(doc.pickedFilePath.toString()).path.split('/').last}":"",
        "expiryDate": doc.qualificationDateController.text,
        "type": doc.selectedDropdownData ?? "",
      };
    }).toList();


    // Build police Qualification
    List<Map<String, dynamic>> firstAidCPRs = firstAidCPR.map((doc) {
      return {
        "document":doc.pickedFilePath != null && doc.pickedFilePath!.isNotEmpty
            ? "/images/${File(doc.pickedFilePath.toString()).path.split('/').last}":"",
        "expiryDate": doc.aidCPRDateController.text,
        "type": doc.selectedDropdownData ?? "",
      };
    }).toList();

    // Build Vaccinations
    List<Map<String, dynamic>> vaccinationList = vaccinations.map((doc) {
      return {
        "certificate":doc.pickedFilePath != null && doc.pickedFilePath!.isNotEmpty
            ? "/images/${File(doc.pickedFilePath.toString()).path.split('/').last}":"",
        "publishDate": doc.vaccinDateController.text,
        "type": doc.selectedDropdownData ?? "",
      };
    }).toList();


    // Full body
    final Map<String, dynamic> body = {
      "passport": {
        "expiryDate": passportExpiry ?? "",
        "document": passportFilePath!.isEmpty ? "" :"/images/${File(passportFilePath.toString()).path.split('/').last}"
      },
      "drivingLicense": {
        "frontDocument": driveFrontPath!.isEmpty ? "" :"/images/${File(driveFrontPath.toString()).path.split('/').last}",
        "backDocument": driveBackPath!.isEmpty ? "" : "/images/${File(driveBackPath.toString()).path.split('/').last}",
        "expiryDate": driveExpiry
      },
      "checks": policeCheckList,

      "carInsuranceCertificate": {
        "certificate": carInsFilePath!.isEmpty ? "" : "/images/${File(carInsFilePath.toString()).path.split('/').last}",
        "expiryDate": carInsExpiry ?? "",
        "type": carInsDropdown ?? ""
      },
      "qualification":qualificationList,

      "firstAid":firstAidCPRs,

      "workingWithChildren": {
        "document": workingWithChildrenFilePath!.isEmpty ? "" : "/images/${File(workingWithChildrenFilePath.toString()).path.split('/').last}" ,
        "expiryDate": workingWithChildrenExpiry
      },
      "vaccination":vaccinationList,
      "abn": {
        "abnNumber": abnNumber,
        "businessName": businessName,
        "gstRegistered": isGSTCheck.value

      },
      "bankDetails": {
        "bsbNumber": bsbNumber,
        "accountNumber": accountNumber

      },



    };

    try {
     String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        ToastMessageHelper.successMessageShowToster(responseBody['message']);
         Get.toNamed(AppRoutes.allBottomBarScreen, preventDuplicates: false);
        print("Upload successful: ${response.body}");
      } else {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'Unknown error occurred';
        ToastMessageHelper.errorMessageShowToster(errorMessage);

        print("response data -----------${response.body}");
        print("Upload failed: ${response.statusCode} ${response.body}");
      }
    }on SocketException {
      _handleError('No internet connection');
    } on TimeoutException {
      _handleError('Request timed out');
    } on FormatException {
      _handleError('Invalid server response');
    } catch (e) {
      print("Error uploading documents: $e");
    }
  }
  void _handleError(String message) {
    ToastMessageHelper.errorMessageShowToster(message);
  }

  /// --------------update Profile-----------------------
  RxBool isUpdateLoading = false.obs;

  Future<void> upDateProfile({
     File? image,
     String? firstName,
    required String? lastName,
    required List<String> languagesSpoken,
    required String? residentialAddress,
    required String? phoneNumber,
    required String? gender,
    required String? dateOfBirth,
    required String? suburb,
    required String? state,
    required String? emergencyContactPhoneNumber,
    required String? emergencyContactFirstName,
    required String? emergencyContactLastName,
    required String? emergencyContactRelationship,
    String? referralSourceEnum,

  }) async {
    isUpdateLoading(true);

    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];

    var body = {
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
      "residentialAddress": residentialAddress ?? '',
      "phoneNumber": phoneNumber ?? '',
      "gender": gender ?? '',
      "dateOfBirth": dateOfBirth ?? '',
      "suburb": suburb ?? '',
      "state": state ?? '',
      "emergencyContactPhoneNumber": emergencyContactPhoneNumber ?? '',
      "emergencyContactFirstName": emergencyContactFirstName ?? '',
      "emergencyContactLastName": emergencyContactLastName ?? '',
      "emergencyContactRelationship": emergencyContactRelationship ?? '',
      "referralSourceEnum": referralSourceEnum ?? ''
    };
    print("tokkkkkkkkkeeeeeeeeeennnnnnnnnnn=>$bearerToken");
    // For languagesSpoken, send each language separately
    for (int i = 0; i < languagesSpoken.length; i++) {
      body["languagesSpoken[$i]"] = languagesSpoken[i];
    }
    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateProEndPoint,
      body,
      headers:headers ,
      multipartBody: multipartBody,
    );


    print("update=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      // await PrefsHelper.setString(
      //     AppConstants.userId, response.body['data']['_id']);
      // await PrefsHelper.setString(AppConstants.firstname, response.body['data']['name']);
      // await PrefsHelper.setString(AppConstants.firstname, response.body['data']['phone']);
      ToastMessageHelper.successMessageShowToster(response.body["message"]);
      // Get.back();
      Get.toNamed(AppRoutes.profileSetupDocScreen,preventDuplicates: false);
      update();

      isUpdateLoading(false);
    }else{
      isUpdateLoading(false);
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
    }
  }





  RxBool isUser = false.obs;
  Rx<GetUserData> getUserResponseModel = GetUserData().obs;
  getUserData() async {
    isUser(true);
    try {
      var response = await ApiClient.getData(ApiConstants.getUserEndPoint);
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        getUserResponseModel.value = GetUserData.fromJson(response.body['data']);
      } else {
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "Unexpected error");
      }
    } catch (e, stacktrace) {
      print("Exception: $e");
      print("Stacktrace: $stacktrace");
      // ToastMessageHelper.errorMessageShowToster("An error occurred: $e");
    } finally {
      isUser(false);
    }
  }






  /// --------------update Profile-----------------------
   RxBool isImage = false.obs;
  //
  // Future<void> uploadIMG({
  //   File? image,
  // }) async {
  //   isImage(true);
  //
  //   String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $bearerToken'
  //   };
  //   List<MultipartBody> multipartBody =
  //   image == null ? [] : [MultipartBody("image", image)];
  //
  //   var body = {
  //     "":""
  //   };
  //   print("tokkkkkkkkkeeeeeeeeeennnnnnnnnnn=>$bearerToken");
  //
  //   var response = await ApiClient.patchMultipartData(
  //     ApiConstants.uploadImgEndPoint,
  //     body,
  //     headers:headers,
  //     multipartBody: multipartBody,
  //   );
  //
  //
  //   print("update=======> ${response.body}");
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     await PrefsHelper.setString(AppConstants.firstname, response.body['data']['path']);
  //     await PrefsHelper.setString(AppConstants.firstname, response.body['data']['publicFileURL']);
  //
  //     ToastMessageHelper.successMessageShowToster(response.body["message"]);
  //     // Get.back();
  //     Get.toNamed(AppRoutes.profileSetupDocScreen,preventDuplicates: false);
  //     update();
  //
  //     isUpdateLoading(false);
  //   }else{
  //     isUpdateLoading(false);
  //     ToastMessageHelper.errorMessageShowToster(response.body['message']);
  //   }
  // }
  Future<String?> uploadIMG({File? image}) async {
    if (image == null) return null;

    isImage(true);

    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Authorization': 'Bearer $bearerToken',
    };

    List<MultipartBody> multipartBody = [MultipartBody("image", image)];
    Map<String, String> body = {};
// You don't need to send any text field

    final response = await ApiClient.postMultipartData(
      ApiConstants.uploadImgEndPoint,
      body,
      headers: headers,
      multipartBody: multipartBody,
    );

    isImage(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      final publicFileURL = response.body['data']['publicFileURL'];
      return publicFileURL;
    } else {
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      return null;
    }
  }




  ///======================ForgotOtpVerify+++++++++++++++++++
  RxBool  forPassLoading = false.obs;
  Future<void>  changePass(String oldPassword, String newPassword, String confirmPassword) async{
    forPassLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body ={
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    };
    var response = await ApiClient.postData("${ApiConstants.changePassAPI}",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){

      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());
      Get.back();
      forPassLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      forPassLoading(false);
    }
  }

  /// ============get isUser=============
  RxBool isAbout = false.obs;
  Rx<TermAboutPrivacyResponseModel> termAboutPrivacyResponseModel = TermAboutPrivacyResponseModel().obs;
  getAboutData({required bool isAbouts,required bool isTerms}) async {
    try{
      isAbout(true);
      var response = await ApiClient.getData(isAbouts == true ?"/about": isTerms == true ? "/terms": "/privacy");
      print("User data-=-=-=--=========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        termAboutPrivacyResponseModel.value = TermAboutPrivacyResponseModel.fromJson(response.body['data']);
        isUser(false);
      }else{
        isAbout(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
      }
    }
    catch(e){
      // ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isAbout(false);
    }
  }





  RxBool deleteAccLoading = false.obs;
  deleteAccount() async {
    deleteAccLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    String id = await PrefsHelper.getString(AppConstants.userId);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };


    var response = await ApiClient.deleteData(
        "/auth/account-delete?id=$id",
        headers: headers);

    print("=======>cDelete Acc:: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.remove(AppConstants.userId);
      await PrefsHelper.remove(AppConstants.firstname);
      await PrefsHelper.remove(AppConstants.lastname);
      await PrefsHelper.remove(AppConstants.image);
      await PrefsHelper.remove(AppConstants.email);
      await PrefsHelper.remove(AppConstants.businessID);
      await PrefsHelper.remove(AppConstants.type);
      await PrefsHelper.remove(AppConstants.bearerToken);
      Get.offNamed(AppRoutes.signInScreen);
      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());
      deleteAccLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      deleteAccLoading(false);
    }
  }





  /// --------------update Profile-----------------------
  RxBool againIsUpdateLoading = false.obs;

  Future<void> againUpDateProfile({
    File? image,
    String? firstName,
    String? lastName,
    required List<String> languagesSpoken,
    String? residentialAddress,
    String? gender,
    String? dateOfBirth,



  }) async {
    againIsUpdateLoading(true);

    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];

    var body = {
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
      "residentialAddress": residentialAddress ?? '',
      "gender": gender ?? '',
      "dateOfBirth": dateOfBirth ?? '',
    };
    print("tokkkkkkkkkeeeeeeeeeennnnnnnnnnn=>$bearerToken");
    // For languagesSpoken, send each language separately
    for (int i = 0; i < languagesSpoken.length; i++) {
      body["languagesSpoken[$i]"] = languagesSpoken[i];
    }
    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateProEndPoint,
      body,
      headers:headers ,
      multipartBody: multipartBody,
    );


    print("update=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      // await PrefsHelper.setString(
      //     AppConstants.userId, response.body['data']['_id']);
      // await PrefsHelper.setString(AppConstants.firstname, response.body['data']['name']);
      // await PrefsHelper.setString(AppConstants.firstname, response.body['data']['phone']);
      getUserData();
      Get.back();
      update();
      ToastMessageHelper.successMessageShowToster(response.body["message"]);
      // Get.toNamed(AppRoutes.profileSetupDocScreen,preventDuplicates: false);
      update();

      againIsUpdateLoading(false);
    }else{
      againIsUpdateLoading(false);
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
    }
  }

  Rx<DocumentResponseModel> documentResponseModel = DocumentResponseModel().obs;


  fetchDocumentResponse() async {
    try{
      isAbout(true);
      var response = await ApiClient.getData(ApiConstants.getDocAPIEndPoint);
      print("User data-=-=-=--=========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        documentResponseModel.value = DocumentResponseModel.fromJson(response.body['data']);
        isUser(false);
      }else{
        isAbout(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
      }
    }
    catch(e){
      // ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isAbout(false);
    }
  }



}