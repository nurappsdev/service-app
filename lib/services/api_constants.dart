
class ApiConstants{
///====================Server=====================================
//   static const String baseUrl = "http://192.168.40.219:3010/v1";
//   static const String imageBaseUrl = "http://192.168.40.219:3010";
//   static const String socketBaseUrl = "ws://192.168.40.219:3000";
  ///====================live=====================================
  static const String baseUrl = "https://milon8086.sobhoy.com/api/v1";
  static const String socketBaseUrl = "https://milon8086.sobhoy.com";
  static const String imageBaseUrl = "https://milon8086.sobhoy.com";


  static const String signUpEndPoint = "/auth/register";
  static const String userVerifyOTP = "/auth/verify-otp";
  static const String resendOTPEndPoint = "/auth/resend-otp?email=";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPassEndPoint = "/auth/forget-password";



  static const String profileDocAPIEndPoint = "/document/upload";
  static const String getDocAPIEndPoint = "/document/my-documents";
  static const String homeBookingApi = "/shift/today-shift";



  static const String cartEndPoint = "/user/sweepstakes/my-cart";
  static const String paymentEndPoint = "/payment/add";
  static const String getUserEndPoint = "/auth/my-profile";
  static const String resetPassEndPoint = "/auth/reset-password";
  static const String suggetionEndPoint = "/support/need";
  static const String updateProEndPoint = "/auth/profile-update";
  static const String uploadImgEndPoint = "/document/upload-file";
  static const String changePassAPI = "/auth/change-password";
  static const String categoryEndPoint = "/category?limit=200";
  static const String bannerEndPoint = "/user/advertisements/get";
  static const String posterEndPoint = "/banner/get-random-poster";
  static const String rewardsEndPoint = "/user/sweepstakes/my-rewards?limit=5000";
  static  String sweepstakes(String page) => "/user/sweepstakes/get?page=$page";
  static  String smyEntriesAPIEndPoint(String page) => "/user/sweepstakes/my-entries?page=$page";
  static  String getOpenJobDetailsEndPoint(String id) => "/shift/get/$id";
  static  String getBookingDetailsEndPoint(String id) => "/shift/my-booking/$id";
  static  String notificationList(String page) => "/notification?page=$page";
}