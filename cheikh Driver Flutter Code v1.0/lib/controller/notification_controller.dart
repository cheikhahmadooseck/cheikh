import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../config/data_store.dart';
import '../model/notification_model.dart';
import '../widget/common.dart';

class NotificationController extends GetxController implements GetxService {

  NotificationModel? notificationModel;

  String notificationId = "";

  notification({required context,required String requestId}) async{
    Map body = {
      "uid": getData.read("UserLogin")["id"].toString(),
      "mid": notificationId,
      "request_id": requestId
    };

    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    var response = await http.post(Uri.parse(Config.baseUrl + Config.notification), body: jsonEncode(body), headers: userHeader);

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == true) {
        notificationModel = notificationModelFromJson(response.body);
        if (notificationModel!.result == true) {
          Get.back();
          update();
          snackBar(context: context, text: "${data["message"]}");
          return response.body;
        } else {
          snackBar(context: context, text: notificationModel!.message.toString());
        }
      } else {
        snackBar(context: context, text: "${data["message"]}");
      }
    } else {
      snackBar(
          context: context,
          text:
          "Please update the content from the backend panel. It appears that the correct data was not uploaded, or there may be issues with the data that was added.");
    }
  }
}