

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:zippygo/common_code/config.dart';

// Future<void> initPlatformState({context}) async {
//   OneSignal.shared.setAppId(Config.oneSignel).then((value) {
//     print("accepted123:------  ");
//   });
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     print("accepted:------   $accepted");
//   });
//   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//     print("Accepted OSPermissionStateChanges : $changes");
//   });
//
// }


Future<void> initPlatformState({context}) async {

  // OneSignal.shared.setAppId(Config.oneSignel).then((value) {
  //   print("accepted123:------  ");
  // });
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("accepted:------   $accepted");
  // });
  // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //   print("Accepted OSPermissionStateChanges : $changes");
  // });

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(Config.oneSignel);
  OneSignal.Notifications.requestPermission(true).then((value) {
    print("signal value:- ${value}");
  },);

}