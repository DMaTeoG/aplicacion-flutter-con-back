import 'package:get/get.dart';
import '../models/review.dart';
import '../services/review_service.dart';
import '../utils/device_id.dart';

class ReviewController extends GetxController {
  final _service = ReviewService();

  var reviews = <Review>[].obs;
  var isLoading = true.obs;

  Future<void> fetchReviews(String itemId) async {
    try {
      isLoading.value = true;
      reviews.value = await _service.fetchReviews(itemId);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addReview({
    required String itemId,
    required int rating,
    String? comment,
  }) async {
    final deviceId = await DeviceId.getDeviceId();
    await _service.addReview(
      deviceId: deviceId,
      itemId: itemId,
      rating: rating,
      comment: comment,
    );
    await fetchReviews(itemId);
  }
}
