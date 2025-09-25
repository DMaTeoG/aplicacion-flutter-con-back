import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import 'item_detail_screen.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());

    return Scaffold(
      appBar: AppBar(title: const Text("Reviews")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.items.isEmpty) {
          return const Center(child: Text("No hay items aún"));
        }
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, i) {
            final item = controller.items[i];
            return ListTile(
              leading: item.imageUrl != null
                  ? Image.network(item.imageUrl!, width: 50, fit: BoxFit.cover)
                  : const Icon(Icons.book),
              title: Text(item.title),
              subtitle: Text("⭐ ${item.avgRating.toStringAsFixed(1)} (${item.totalReviews})"),
              onTap: () {
                Get.to(() => ItemDetailScreen(item: item));
              },
            );
          },
        );
      }),
    );
  }
}
