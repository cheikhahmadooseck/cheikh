import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:zippygo/common_code/config.dart';
import '../api_model/home_wallete_api_model.dart';
import 'calculate_api_controller.dart';


class HomeWalletApiController extends GetxController implements GetxService {
  HomeWalleteApiModel? homeWalleteApiModel;
  bool isLoading = true;

  Future homwwalleteApi({context,required String uid}) async {
    Map body = {
      "uid": uid,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.baseurl + Config.homewallte),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + HomeWalletApiController + + + + + + :--- $body');
    print('- - - - - HomeWalletApiController - - - - - - :--- ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == true) {
        homeWalleteApiModel = homeWalleteApiModelFromJson(response.body);

        if (homeWalleteApiModel!.result == true) {
          // Get.offAll(BoardingPage());
          update();

          showToastForDuration("${data["message"]}", 1);
          isLoading = false;
          return data;

        } else {

          showToastForDuration("${data["message"]}", 1);
          Get.back();
          return data;
        }

      } else {

        showToastForDuration("${data["message"]}", 1);
        Get.back();
        // snackbar(context: context, text: "${data["message"]}");
        return data;
      }

    } else {

      showToastForDuration("Somthing went wrong!.....", 3);

      // snackbar(context: context, text: "Somthing went wrong!.....");
    }
  }
}

