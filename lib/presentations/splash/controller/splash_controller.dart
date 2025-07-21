import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  var showButton = false.obs;
  var vsVisible = false.obs;
  var aiVisible = false.obs;

  @override
  void onInit() {
    super.onInit();


    Timer(const Duration(seconds: 2), () {
      vsVisible.value = true;
    });


    Timer(const Duration(seconds: 3), () {
      aiVisible.value = true;
    });


    Timer(const Duration(seconds: 4), () {
      showButton.value = true;
    });
  }
}
