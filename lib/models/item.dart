class Item {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final double avgRating;
  final int totalReviews;

  Item({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.avgRating = 0,
    this.totalReviews = 0,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
    );
  }
}
