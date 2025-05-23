import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:zippygo/common_code/config.dart';
import '../api_model/account_delete_api_model.dart';


class DeleteAccount extends GetxController implements GetxService {
  AccountDeleteApiModel? deleteApiModel;
  bool isLoading = true;


  Future deleteaccountApi({required String id}) async {
    Map body = {
      "id": id,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.baseurl + Config.delteuseraccount),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + Delete + + + + + + $body');
    print('- - - - - Delete Account - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == true) {
        deleteApiModel = accountDeleteApiModelFromJson(response.body);
        if (deleteApiModel!.result == true) {
          isLoading = false;
          Fluttertoast.showToast(
            msg: "${deleteApiModel!.message}",
          );
          update();
          return data;
        } else {
          Fluttertoast.showToast(
            msg: "${deleteApiModel!.message}",
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "${data["message"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}