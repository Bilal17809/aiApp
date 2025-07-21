import 'package:get/get.dart';
import '../controller/fact_controller.dart';

class FactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FactController());
  }
}
