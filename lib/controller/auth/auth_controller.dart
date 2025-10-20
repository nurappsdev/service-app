
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../routes/app_routes.dart';
import '../../services/client_service.dart';
import '../../services/firebase_service.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';

class AuthController extends GetxController{
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  RxBool signUpLoading = false.obs;
  Future<void> signUpHandle({
    required String email,
    required String password,
  }) async {
    signUpLoading(true);
    String roleType = await PrefsHelper.getString(AppConstants.type);
    var headers = {'Content-Type': 'application/json'};
    var body = {

      "email": email,
      "password": password,
      "role": roleType,
    };
    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );
    print("regggggggggggggggggggggggggggg${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      Get.toNamed(AppRoutes.verifyScreen, preventDuplicates: false,parameters: {'email':email,}
      );

      ToastMessageHelper.successMessageShowToster(
          "Account create successful.\n \nNow you have a one time code your email");
      signUpLoading(false);
    } else {
      ToastMessageHelper.errorMessageShowToster("${response.body["message"]}");
      signUpLoading(false);
    }
  }
  ///======================otpVerify+++++++++++++++++++
  RxBool  verifyLoading = false.obs;
  Future<void> otpVerify(String code) async{
    verifyLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body ={
      "otp": code
    };
    var response = await ApiClient.postData(ApiConstants.userVerifyOTP,
        jsonEncode(body),
        headers: headers
    );
    print("SIGN UP OTP =====================dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      print("token==================> ${response.body['data']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      await PrefsHelper.setString(AppConstants.userId, response.body['data']['email']);
      // if(Get.parameters['screenType'] == 'forgot'){
      //   // Get.toNamed(AppRoutes.resetPassScreen,preventDuplicates: false);
      // } else{
      //   await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      //   Get.toNamed(AppRoutes.bottomScreen,preventDuplicates: false);
      //   ToastMessageHelper.successMessageShowToster(response.body['message'].toString());
      // }
      if(Get.parameters['screenType'] == 'forgot'){
        Get.toNamed(AppRoutes.resetPassScreen,preventDuplicates: false);
      } else {
        Get.toNamed(AppRoutes.profileSetupScreen, preventDuplicates: false);
        //Get.toNamed(AppRoutes.allBottomBarScreen, preventDuplicates: false);
      }
      verifyLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("${response.body['data']}");
      verifyLoading(false);
    }
  }



  ///===========login===========<>

  RxBool loadingLoading = false.obs;

  Future<void> loginHandle({  required String email,
    required String password,}) async {
    try {
      // Basic input validation
      // if (email.isEmpty || password.isEmpty) {
      //   ToastMessageHelper.errorMessageShowToster('Please fill in all fields');
      //   return;
      // }

      loadingLoading(true);
      FirebaseService _firebaseService = FirebaseService();
      String? fcmToken = await _firebaseService.getFCMToken();
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'email': email,
        'password': password,
        'fcmToken': fcmToken
      });

      final response = await ApiClient.postData(
        ApiConstants.signInEndPoint,
        body,
        headers: headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        PrefsHelper.setString(AppConstants.bearerToken, data['token']);
        await Future.wait([
          PrefsHelper.setString(AppConstants.bearerToken, data['token']),
          PrefsHelper.setString(AppConstants.userId, data['user']['_id']),
          PrefsHelper.setString(AppConstants.email, data['user']['email']),
        ]);

       Get.toNamed(AppRoutes.allBottomBarScreen, preventDuplicates: false);
      // Get.toNamed(AppRoutes.profileSetupScreen, preventDuplicates: false);
        ToastMessageHelper.successMessageShowToster(response.body['message']);
      } else {
        ToastMessageHelper.errorMessageShowToster(
            response.body['message'] ?? 'Login failed. Please try again.'
        );
      }
    } on SocketException {
      _handleError('No internet connection');
    } on TimeoutException {
      _handleError('Request timed out');
    } on FormatException {
      _handleError('Invalid server response');
    } catch (e) {
      _handleError('An unexpected error occurred');
    } finally {
      loadingLoading(false);
    }
  }
  void _handleError(String message) {
    ToastMessageHelper.errorMessageShowToster(message);
  }





  ///===================Forgot Password ======================
  RxBool forgotLogin = false.obs;
  forgotHandle(String email,screenType) async {
    forgotLogin(true);
    var body = {
      'email': email
    };

    var response = await ApiClient.postData(
        ApiConstants.forgotPassEndPoint,
        jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data'];
      await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
      ToastMessageHelper.successMessageShowToster(response.body['message']);
     Get.toNamed(AppRoutes.verifyScreen, parameters: {"screenType": "forgot"},preventDuplicates: false);
      forgotLogin(false);
    } else {
      {
        ToastMessageHelper.errorMessageShowToster(response.body['message']);
        forgotLogin(false);
      }
    }
  }


  ///======================ForgotOtpVerify+++++++++++++++++++
  RxBool  forVerifyLoading = false.obs;
  Future<void>  forgotOtpVerify(String code) async{
    forVerifyLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body ={
      "code": code
    };
    var response = await ApiClient.postData("/auth/verify-forgot-password-code",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      print("token==================> ${response.body['data']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      //Get.toNamed(AppRoutes.resetPassScreen,preventDuplicates: false);

      if(Get.parameters['screenType'] == 'forgot'){
        Get.toNamed(AppRoutes.resetPassScreen,preventDuplicates: false);
      } else{
        await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
        Get.toNamed(AppRoutes.allBottomBarScreen,preventDuplicates: false);
      }

      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());
      forVerifyLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      forVerifyLoading(false);
    }
  }



  RxBool resendLoading = false.obs;
  ///=========================Resend OTP==============================
  resendOTP({required String email}) async{
    resendLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {

    };
    print(body['email']);
    var response = await ApiClient.postData(
        "${ApiConstants.resendOTPEndPoint}$email",
        jsonEncode(body),
        headers: headers
    );
    print("responseeeeeeeeee ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      resendLoading(false);
    }else{
      resendLoading(false);
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
    }
  }


  ///===============reset password ========================<>
  RxBool isResetLoading = false.obs;
  resetPassword(String firstController) async{
    isResetLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "password":firstController,
    };

    var response = await ApiClient.postData("${ApiConstants.resetPassEndPoint}", jsonEncode(body),headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201){
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      Get.toNamed(AppRoutes.signInScreen,preventDuplicates: false);
      isResetLoading(false);
    }else{
      isResetLoading(false);
      ToastMessageHelper.errorMessageShowToster(response.body['message']);

    }

  }

}