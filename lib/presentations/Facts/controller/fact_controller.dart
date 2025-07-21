import 'package:ai_app/data/data_sources/local_fact_data.dart';
import 'package:get/get.dart';
import '../../../data/models/fact_model.dart';


class FactController extends GetxController {
  final RxList<FactModel> facts = <FactModel>[].obs;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadFacts();
  }

  void loadFacts() async {
    final loadedFacts = await LocalFactData.loadFacts();
    facts.assignAll(loadedFacts);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}
