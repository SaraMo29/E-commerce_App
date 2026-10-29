import 'package:hive_flutter/hive_flutter.dart';

import '../models/product_model.dart';

class ReviewsLocalDatasource {
  static const String _boxName = 'reviewsBox';

  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }

    return Hive.openBox(_boxName);
  }

  Future<void> saveReviews(
    int productId,
    List<ProductReview> reviews,
  ) async {
    final box = await _openBox();

    final data = reviews.map((review) => review.toJson()).toList();

    await box.put('reviews_$productId', data);
  }

  Future<List<ProductReview>> getReviews(int productId) async {
    final box = await _openBox();

    final data = box.get('reviews_$productId');

    if (data is! List) {
      return [];
    }

    return data
        .whereType<Map>()
        .map(
          (review) => ProductReview.fromJson(
            Map<String, dynamic>.from(review),
          ),
        )
        .toList();
  }
}