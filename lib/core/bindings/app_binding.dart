
import 'package:ai_app/presentations/home/controller/home_contrl.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=>HomeController());

  }
}