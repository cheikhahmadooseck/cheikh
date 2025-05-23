// ignore_for_file: avoid_print
// ignore_for_file: unused_field, unused_element, depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_init_to_null, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_final_fields
// ignore_for_file: unused_import, must_be_immutable, use_super_parameters,
// ignore_for_file: use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, await_only_futures, prefer_const_constructors, avoid_unnecessary_containers, file_names, void_checks, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zippygo/app_screen/pickup_drop_point.dart';
import 'package:zippygo/common_code/colore_screen.dart';
import 'package:zippygo/common_code/common_button.dart';
import 'dart:ui' as ui;
import '../api_code/calculate_api_controller.dart';
import '../api_code/modual_calculate_api_controller.dart';
import 'home_screen.dart';
import 'map_screen.dart';

var lat;
var long;
var address;

class CustomLocationSelectScreen extends StatefulWidget {
  final String bidding;
  final bool pagestate;
  const CustomLocationSelectScreen({super.key, required this.bidding, required this.pagestate});

  @override
  State<CustomLocationSelectScreen> createState() => _CustomLocationSelectScreenState();
}

class _CustomLocationSelectScreenState extends State<CustomLocationSelectScreen> {


  String themeForMap = "";

  mapThemeStyle({required context}){
    if(darkMode == true){
      setState(() {
        DefaultAssetBundle.of(context).loadString("assets/dark_mode_style.json").then((value) {
          setState(() {
            themeForMap = value;
          });
        },);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // datagetfunction();
    destinationlat = [];
    destinationlong = [];
    mapThemeStyle(context: context);

    setState(() {
      fun().then((value) {
        setState(() {
        });
        getCurrentLatAndLong(lat, long);
      },);
    });
  }

  Set<Marker> markers = Set();
  late GoogleMapController mapController1;

  Future fun() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');
    _onAddMarkerButtonPressed(currentLocation.latitude, currentLocation.longitude);
    getCurrentLatAndLong(
      currentLocation.latitude,
      currentLocation.longitude,
    );
    print("????????????" + currentLocation.longitude.toString());
    print("SECOND USER CURRENT LOCATION : --  ${address}");

  }


  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }


  getCurrentLatAndLong(double latitude, double longitude) async {

    lat = latitude;
    long = longitude;

    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemarks) {
      address = '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}';
      print("FIRST USER CURRENT LOCATION :-- $address");
    });

  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(double? lat, long) async {
    final Uint8List markIcon = await getImages("assets/pickup.png", 80);
    markers.add(Marker(
      markerId: const MarkerId("1"),
      onTap: () {
        showDialog(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                alignment: const Alignment(0,-0.22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${address}",
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Text(
                      //   "harsh savaliya",
                      //   maxLines: 1,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },);
          },
        );
      },
      position: LatLng(double.parse(lat.toString()),double.parse(long.toString())),
      // icon: BitmapDescriptor.defaultMarker,
      icon: BitmapDescriptor.fromBytes(markIcon),
    ));
    setState(() {

    });
  }

  CalculateController calculateController = Get.put(CalculateController());
  Modual_CalculateController modual_calculateController = Get.put(Modual_CalculateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: CommonButton(containcolore: theamcolore, onPressed1: () {

          // if(picanddrop == false){
          //   print("++++++pickup run+++++++");
          //   pickupcontroller.text = address;
          //   if (pickupcontroller.text.isNotEmpty && dropcontroller.text.isNotEmpty) {
          //     print("++++++++++++++++done++++++++++++++++");
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) =>  HomeScreen(latpic: lat,longpic: long,latdrop: latitudedrop,longdrop: longitudedrop,destinationlat: destinationlat,destinationlong: destinationlong,)),
          //       MaterialPageRoute(builder: (context) => HomeScreen(latpic: lat,longpic: long,latdrop: latitudedrop,longdrop: longitudedrop,destinationlat: destinationlat,)),
          //     );
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) =>  HomeScreen(latpic: lat,longpic: long,latdrop: latitudedrop,longdrop: longitudedrop,destinationlat: [],destinationlong: [],)),
          //     // );
          //   }
          // }else{
          //   print("++++++drop run+++++++");
          //   dropcontroller.text = address;
          //   latitudedrop = lat;
          //   longitudedrop = long;
          //   if (pickupcontroller.text.isNotEmpty && dropcontroller.text.isNotEmpty) {
          //     print("++++++++++++++++done++++++++++++++++");
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) =>  HomeScreen(latpic: latitudepick,longpic: longitudepick,latdrop: lat,longdrop: long,destinationlat: destinationlat,)),
          //     );
          //   }
          // }



          if(picanddrop == false){
            print("++++++pickup run+++++++");
            pickupcontroller.text = address;


            if (pickupcontroller.text.isNotEmpty && dropcontroller.text.isNotEmpty) {
              print("++++++++++++++++done++++++++++++++++");

              widget.bidding == "1" ?  Get.offAll(const MapScreen()) : widget.pagestate == true ? Navigator.pop(context, RefreshData(true)) :  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(latpic: lat,longpic: long,latdrop: latitudedrop,longdrop: longitudedrop,destinationlat: destinationlat,)),
              );

              widget.bidding == "1" ?
              calculateController.calculateApi(context: context,uid: useridgloable.toString(), mid: mid, mrole: mroal, pickup_lat_lon: "${latitudepick},${longitudepick}", drop_lat_lon: "${latitudedrop},${longitudedrop}", drop_lat_lon_list: onlypass).then((value) {
                // print("********** value **********:----- ${value}");
                // print("********** value **********:----- ${value["drop_price"]}");
                // print("********** value **********:----- ${value["vehicle"]["minimum_fare"]}");
                // print("********** value **********:----- ${value["vehicle"]["maximum_fare"]}");

                dropprice = 0;
                minimumfare = 0;
                maximumfare = 0;

                if(value["Result"] == true){
                  dropprice = value["drop_price"];
                  minimumfare = value["vehicle"]["minimum_fare"];
                  maximumfare = value["vehicle"]["maximum_fare"];
                  responsemessage = value["message"];


                  tot_hour = value["tot_hour"].toString();
                  tot_time = value["tot_minute"].toString();
                  vehicle_id = value["vehicle"]["id"].toString();
                  vihicalrice = double.parse(value["drop_price"].toString());
                  totalkm = double.parse(value["tot_km"].toString());
                  tot_secound = "0";

                  vihicalimage = value["vehicle"]["map_img"].toString();
                  vihicalname = value["vehicle"]["name"].toString();

                }else{
                  print("jojojojojojojojojojojojojojojojojojojojojojojojo");
                }


                print("********** dropprice **********:----- ${dropprice}");
                print("********** minimumfare **********:----- ${minimumfare}");
                print("********** maximumfare **********:----- ${maximumfare}");

              },):
              modual_calculateController.modualcalculateApi(context: context,uid: useridgloable.toString(), mid: mid, mrole: mroal, pickup_lat_lon: "${latitudepick},${longitudepick}", drop_lat_lon: "${latitudedrop},${longitudedrop}", drop_lat_lon_list: onlypass).then((value) {
                // midseconde = modual_calculateController.modualCalculateApiModel!.caldriver![0].id!;
                // vihicalrice = double.parse(modual_calculateController.modualCalculateApiModel!.caldriver![0].dropPrice!.toString());
                totalkm = double.parse(modual_calculateController.modualCalculateApiModel!.caldriver![0].dropKm!.toString());
                tot_time = modual_calculateController.modualCalculateApiModel!.caldriver![0].dropTime!.toString();
                tot_hour = modual_calculateController.modualCalculateApiModel!.caldriver![0].dropHour!.toString();
                tot_secound = "0";
                vihicalname = modual_calculateController.modualCalculateApiModel!.caldriver![0].name!.toString();
                vihicalimage = modual_calculateController.modualCalculateApiModel!.caldriver![0].image!.toString();
                vehicle_id = modual_calculateController.modualCalculateApiModel!.caldriver![0].id!.toString();
              },);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen(latpic: lat,longpic: long,latdrop: latitudedrop,longdrop: longitudedrop,destinationlat: destinationlat,)),
              // );
            }
          }else{
            print("++++++drop run+++++++");
            dropcontroller.text = address;
            latitudedrop = lat;
            longitudedrop = long;
            if (pickupcontroller.text.isNotEmpty && dropcontroller.text.isNotEmpty) {
              print("++++++++++++++++done++++++++++++++++");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen(latpic: latitudepick,longpic: longitudepick,latdrop: lat,longdrop: long,destinationlat: destinationlat,)),
              // );

              widget.bidding == "1" ? Get.offAll(const MapScreen()) : widget.pagestate == true ? Navigator.pop(context, RefreshData(true)) : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(latpic: latitudepick,longpic: longitudepick,latdrop: lat,longdrop: long,destinationlat: destinationlat,)),
              );
              widget.bidding == "1" ?
              calculateController.calculateApi(context: context,uid: useridgloable.toString(), mid: mid, mrole: mroal, pickup_lat_lon: "${latitudepick},${longitudepick}", drop_lat_lon: "${latitudedrop},${longitudedrop}", drop_lat_lon_list: onlypass).then((value) {
                // print("********** value **********:----- ${value}");
                // print("********** value **********:----- ${value["drop_price"]}");
                // print("********** value **********:----- ${value["vehicle"]["minimum_fare"]}");
                // print("********** value **********:----- ${value["vehicle"]["maximum_fare"]}");

                dropprice = 0;
                minimumfare = 0;
                maximumfare = 0;

                if(value["Result"] == true){
                  amountresponse = "true";
                  dropprice = value["drop_price"];
                  minimumfare = value["vehicle"]["minimum_fare"];
                  maximumfare = value["vehicle"]["maximum_fare"];
                  responsemessage = value["message"];

                  tot_hour = value["tot_hour"].toString();
                  tot_time = value["tot_minute"].toString();
                  vehicle_id = value["vehicle"]["id"].toString();
                  vihicalrice = double.parse(value["drop_price"].toString());
                  totalkm = double.parse(value["tot_km"].toString());
                  tot_secound = "0";

                  vihicalimage = value["vehicle"]["map_img"].toString();
                  vihicalname = value["vehicle"]["name"].toString();

                  print(".......>>>>>> ${tot_hour}");
                  print(".......>>>>>> ${tot_time}");
                  print(".......>>>>>> ${vehicle_id}");
                  print(".......>>>>>> ${vihicalrice}");
                  print(".......>>>>>> ${totalkm}");
                  print(".......>>>>>> ${totalkm}");
                  print(".......>>>>>> ${totalkm}");

                }else{
                  amountresponse = "false";
                  print("jojojojojojojojojojojojojojojojojojojojojojojojo");
                }

                print("********** dropprice **********:----- ${dropprice}");
                print("********** minimumfare **********:----- ${minimumfare}");
                print("********** maximumfare **********:----- ${maximumfare}");

              },):
              modual_calculateController.modualcalculateApi(context: context,uid: useridgloable.toString(), mid: mid, mrole: mroal, pickup_lat_lon: "${latitudepick},${longitudepick}", drop_lat_lon: "${latitudedrop},${longitudedrop}", drop_lat_lon_list: onlypass).then((value) {

                // midseconde = modual_calculateController.modualCalculateApiModel!.caldriver![0].id!;
                // vihicalrice = double.parse(modual_calculateController.modualCalculateApiModel!.caldriver![0].dropPrice!.toString());
                totalkm = double.parse(modual_calculateController.modualCalculateApiModel!.caldriver![0].dropKm!.toString());
                tot_time = modual_calculateController.modualCalculateApiModel!.caldriver![0].dropTime!.toString();
                tot_hour = modual_calculateController.modualCalculateApiModel!.caldriver![0].dropHour!.toString();
                tot_secound = "0";
                vihicalname = modual_calculateController.modualCalculateApiModel!.caldriver![0].name!.toString();
                vihicalimage = modual_calculateController.modualCalculateApiModel!.caldriver![0].image!.toString();
                vehicle_id = modual_calculateController.modualCalculateApiModel!.caldriver![0].id!.toString();


                print("GOGOGOGOGOGOGOGOGOGOGOGOG:- ${midseconde}");
                print("GOGOGOGOGOGOGOGOGOGOGOGOG:- ${vihicalrice}");
                // setState((){});

              },);

            }
          }




        },context: context,txt1: "Done"),
      ),
      body: GoogleMap(
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
        },
        initialCameraPosition: const CameraPosition(target: LatLng(21.2408, 72.8806), zoom: 13),
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onTap: (argument) {
          setState(() {});
          _onAddMarkerButtonPressed(argument.latitude, argument.longitude);
          lat = argument.latitude;
          long = argument.longitude;
          getCurrentLatAndLong(
            lat,
            long,
          );
          print("**lato****:--- ${lat}");
          print("+++longo+++:--- ${long}");
          print("--------------------------------------");
          print("hfgjhvhjwfvhjuyfvf:-=---  ${address}");
        },
        myLocationEnabled: false,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (controller) {
          setState(() {
            controller.setMapStyle(themeForMap);
            mapController1 = controller;
          });
        },
      ),
    );
  }
}
