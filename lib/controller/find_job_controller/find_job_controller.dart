
import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../routes/app_routes.dart';
import '../../services/client_service.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';

class FindJobController extends GetxController{

  RxList<OpenAppliedJobResponseModel> openAppliedJobResponseModel = <OpenAppliedJobResponseModel>[].obs;


  ///=================pagination----------------
  ///----------------------- home sweepstakes list-=---------------
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getJobAppliedData();

      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }


  RxBool isJob = false.obs;

  Future<void> getJobAppliedData() async {
    try {
      if(page.value == 1){
        openAppliedJobResponseModel.clear();
        isJob(true);
      }
      var response = await ApiClient.getData( "/shift?type=open&page=${page.value}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        totalPage = jsonDecode(response.body['pagination']['totalPage'].toString()) ?? 0;
        currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
        totalResult = jsonDecode(response.body['pagination']['totalData'].toString()) ?? 0;
        var data = List<OpenAppliedJobResponseModel>.from(response.body["data"].map((x) => OpenAppliedJobResponseModel.fromJson(x)));
        openAppliedJobResponseModel.addAll(data);

        update();
        isJob(false);
      } else {
        isJob(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
      }
    } catch (e) {
      // ToastMessageHelper.errorMessageShowToster("Error fetching data: $e");
    } finally {
      isJob(false);
    }
  }



  RxBool isOpenDetails = false.obs;
  Rx<OpenJobDetailsResponseModel> openJobDetailsResponseModel = OpenJobDetailsResponseModel().obs;
  getOpenJobDetailsData(String id) async {
    isOpenDetails(true);
    try {
      var response = await ApiClient.getData(ApiConstants.getOpenJobDetailsEndPoint(id));
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        openJobDetailsResponseModel.value = OpenJobDetailsResponseModel.fromJson(response.body['data']);
      }else if(response.statusCode == 404){
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "not found ");
      } else {
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "Unexpected error");
      }
    } catch (e, stacktrace) {
      print("Exception: $e");
      print("Stacktrace: $stacktrace");
      // ToastMessageHelper.errorMessageShowToster("An error occurred: $e");
    } finally {
      isOpenDetails(false);
    }
  }



  RxBool isYesSelected = false.obs;
  RxBool isNoSelected = false.obs;
  RxBool isMaybeSelected = false.obs;



  ///======================ForgotOtpVerify+++++++++++++++++++
  RxBool  isApplyLoading = false.obs;
  Future<void>  jobApply(String inputText, String userApplyId) async{
    isApplyLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body ={
      "input": inputText

    };
    var response = await ApiClient.postData("/shift/apply/$userApplyId",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      getJobAppliedData();
      Get.back();
      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());

      isApplyLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      isApplyLoading(false);
    }
  }


}