import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:zippygo/app_screen/map_screen.dart';
import 'package:zippygo/common_code/config.dart';
import '../api_model/review_api_model.dart';
import 'calculate_api_controller.dart';


class DriverReviewDetailApiController extends GetxController implements GetxService {
  DriverReviewApiModel? driverReviewApiModel;

  Future reviewapi({context,required String uid,required String d_id,required String review,required List def_review,required String tot_star,required String request_id}) async {
    Map body = {
      "uid": uid,
      "d_id": d_id,
      "review": review,
      "tot_star" : tot_star,
      "request_id" : request_id,
      "def_review" : def_review,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.baseurl + Config.review),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + DriverReviewDetailApiController + + + + + + :--- $body');
    print('- - - - - DriverReviewDetailApiController - - - - - - :--- ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == true) {
        driverReviewApiModel = driverReviewApiModelFromJson(response.body);
        if (driverReviewApiModel!.result == true) {
          // Get.offAll(BoardingPage());
          update();
          showToastForDuration("${data["message"]}", 2);
          Get.offAll(const MapScreen());
          return data;

        } else {
          showToastForDuration("${data["message"]}", 2);
          return data;
        }

      } else {
        showToastForDuration("${data["message"]}", 2);
        return data;
      }

    } else {
      showToastForDuration("Somthing went wrong!.....", 2);
    }

  }
}


