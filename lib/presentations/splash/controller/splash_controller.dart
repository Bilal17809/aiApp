import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  var showButton = false.obs;
  var vsVisible = false.obs;
  var aiVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startSequence();
  }

  void _startSequence() async {
    await Future.delayed(const Duration(seconds: 2));
    vsVisible.value = true;

    await Future.delayed(const Duration(seconds: 3));
    aiVisible.value = true;

    await Future.delayed(const Duration(seconds: 3));
    showButton.value = true;
  }
}
