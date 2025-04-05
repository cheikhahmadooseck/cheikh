import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zippygo/common_code/config.dart';

import '../api_model/login_api_model.dart';
import '../app_screen/permisiion_scren.dart';
import '../common_code/common_button.dart';
import '../common_code/push_notification.dart';


  String onesignalkey = "";

void loginSharedPreferencesSet(bool value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("UserLogin", value);
}


class LoginController extends GetxController implements GetxService {
  LoginModel? loginModel;

  loginApi({required context,required String phone, required String password,required String ccode}) async {
    Map body = {
      "phone": phone,
      "password": password,
      "ccode": ccode
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.baseurl + Config.login),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + +$body');
    print('- - - - - - - - - - -${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == true) {
        loginModel = loginModelFromJson(response.body);
        if (loginModel!.result == true) {


          print("{{{{{data}}}} :--  ${ jsonEncode(data["customer_data"])}");

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userLogin", jsonEncode(data["customer_data"]));
          loginSharedPreferencesSet(false);

          onesignalkey = data["general"]["one_app_id"];
          print("==========:----- (${onesignalkey})");
          print("=====Config.oneSignel=====:----- (${Config.oneSignel})");

          initPlatformState(context: context);
          var sendTags = {'subscription_user_Type': 'customer', 'Login_ID': data["customer_data"]["id"].toString()};
          OneSignal.User.addTags(sendTags);







          // loginSharedPreferencesSet(false);
          // Get.offAll(const Bottom_Navigation());

          // OneSignal.shared.sendTag("user_id", data["UserLogin"]["id"]);
          // initPlatformState(context: context);
          Get.offAll(Permission_screen());
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const Permission_screen(),));

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("${data["message"]}"),
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)),
          //   ),
          // );
          snackbar(context: context, text: "${data["message"]}");
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("${loginModel!.message}"),
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)),
          //   ),
          // );
          snackbar(context: context, text: "${data["message"]}");
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("${data["message"]}"),
        //     behavior: SnackBarBehavior.floating,
        //     shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //   ),
        // );
        snackbar(context: context, text: "${data["message"]}");
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text("Something went Wrong....!!!"),
      //     behavior: SnackBarBehavior.floating,
      //     shape:
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //   ),
      // );
      snackbar(context: context, text: "Something went Wrong....!!!");
    }
  }
}