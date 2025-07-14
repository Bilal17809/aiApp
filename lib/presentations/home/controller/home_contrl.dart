import 'package:get/get.dart';

class HomeController extends GetxController{
  final RxInt number=0.obs;

  void increment()=> number.value++;

  void decrement()=> number.value--;
}