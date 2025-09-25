import 'package:get/get.dart';
import '../models/item.dart';
import '../services/item_service.dart';

class ItemController extends GetxController {
  final _service = ItemService();

  var items = <Item>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      items.value = await _service.fetchItems();
    } finally {
      isLoading.value = false;
    }
  }
}
