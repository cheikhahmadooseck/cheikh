import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zippygo/common_code/config.dart';
import '../api_model/map_api_model.dart';

class MapSuggestGetApiController extends GetxController implements GetxService {

  MapApiModel? mapApiModel;
  bool isLoading = true;
  mapApi({required context,required String suggestkey}) async{

    Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    // var response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/place/textsearch/json?query=${suggestkey}%20pi&key=AIzaSyCRF9Q1ttrleh04hqRlP_CqsFCPU815jJk"),headers: userHeader);
    var response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/place/textsearch/json?query=${suggestkey}%20pi&key=${Config.mapkey}"),headers: userHeader);


    var data = jsonDecode(response.body);

    print("hhhhhhhhhhhhhhhhhhhhhhhhhhh");

      if(data["status"] == "OK"){
        print("ffffffffffffffffffffffffffffff");
        mapApiModel = mapApiModelFromJson(response.body);
        isLoading = false;
        update();
      }
      else{

      }

  }
}