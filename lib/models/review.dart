class Review {
  final String id;
  final String deviceId;
  final String itemId;
  final int rating;
  final String? comment;

  Review({
    required this.id,
    required this.deviceId,
    required this.itemId,
    required this.rating,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      deviceId: json['device_id'],
      itemId: json['item_id'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}
