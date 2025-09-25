import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/item.dart';
import '../controllers/review_controller.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  ItemDetailScreen({super.key, required this.item});

  final _commentController = TextEditingController();
  final _rating = 3.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    controller.fetchReviews(item.id);

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(item.description ?? ""),
                const SizedBox(height: 12),
                Obx(() => Row(
                      children: [
                        const Text("Tu calificación:"),
                        const SizedBox(width: 10),
                        DropdownButton<int>(
                          value: _rating.value,
                          items: List.generate(5, (i) => i + 1)
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text("$e ⭐")))
                              .toList(),
                          onChanged: (val) => _rating.value = val!,
                        )
                      ],
                    )),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(labelText: "Comentario"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await controller.addReview(
                      itemId: item.id,
                      rating: _rating.value,
                      comment: _commentController.text,
                    );
                    Get.snackbar("Éxito", "Review enviada correctamente");
                    _commentController.clear();
                  },
                  child: const Text("Enviar review"),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.reviews.isEmpty) {
                return const Center(child: Text("No hay reviews aún"));
              }
              return ListView.builder(
                itemCount: controller.reviews.length,
                itemBuilder: (context, i) {
                  final r = controller.reviews[i];
                  return ListTile(
                    title: Text("⭐ ${r.rating}"),
                    subtitle: Text(r.comment ?? ""),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
