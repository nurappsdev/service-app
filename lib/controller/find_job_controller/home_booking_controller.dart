
import 'package:careshiftapp/services/api_constants.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../services/client_service.dart';

class HomeBookingController extends GetxController{

@override
  onInit(){
  getHomeBookingData();
    super.onInit();
  }
  RxList<GetHomeBookingResponseModel> getHomeBookingResponseModel = <GetHomeBookingResponseModel>[].obs;



  RxBool isBookingHome = false.obs;

  Future<void> getHomeBookingData() async {
    try {

      isBookingHome(true);

      var response = await ApiClient.getData(ApiConstants.homeBookingApi);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = List<GetHomeBookingResponseModel>.from(response.body["data"].map((x) => GetHomeBookingResponseModel.fromJson(x)));
        getHomeBookingResponseModel.addAll(data);


        update();
        isBookingHome(false);
      } else {
        isBookingHome(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
      }
    } catch (e) {
      // ToastMessageHelper.errorMessageShowToster("Error fetching data: $e");
    } finally {
      isBookingHome(false);
    }
  }

}