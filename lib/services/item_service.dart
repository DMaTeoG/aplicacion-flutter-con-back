import '../core/supabase_client.dart';
import '../models/item.dart';

class ItemService {
  final client = SupabaseConfig.client;

  Future<List<Item>> fetchItems() async {
    final response = await client.from('item_with_rating').select();
    return (response as List).map((i) => Item.fromJson(i)).toList();
  }
}
