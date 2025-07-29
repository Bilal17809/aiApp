import 'dart:io';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void initializeOneSignal() {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  if (Platform.isAndroid) {
    OneSignal.initialize("4e2ca6d2-39c2-4228-96d2-6e6de687a151");
    OneSignal.Notifications.requestPermission(true);
  } else if (Platform.isIOS) {
    OneSignal.initialize("5b57822f-9f90-487c-81d7-817f512d0a6f");
    OneSignal.Notifications.requestPermission(true);
  } else {
    print("Unsupported platform for OneSignal");
  }
}