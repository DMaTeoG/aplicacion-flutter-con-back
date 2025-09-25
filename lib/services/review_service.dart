import '../core/supabase_client.dart';
import '../models/review.dart';

class ReviewService {
  final client = SupabaseConfig.client;

  Future<void> addReview({
    required String deviceId,
    required String itemId,
    required int rating,
    String? comment,
  }) async {
    await client.from('reviews').upsert({
      'device_id': deviceId,
      'item_id': itemId,
      'rating': rating,
      'comment': comment,
    });
  }

  Future<List<Review>> fetchReviews(String itemId) async {
    final response = await client
        .from('reviews')
        .select()
        .eq('item_id', itemId)
        .order('created_at', ascending: false);
    return (response as List).map((r) => Review.fromJson(r)).toList();
  }
}
