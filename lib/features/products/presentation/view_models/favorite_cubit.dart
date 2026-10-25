
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteUpdated([]));

  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(ProductModel product) {
    return _favorites.any((item) => item.id == product.id);
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }

    emit(FavoriteUpdated(List.unmodifiable(_favorites)));
  }

  void removeFavorite(ProductModel product) {
    _favorites.removeWhere((item) => item.id == product.id);

    emit(FavoriteUpdated(List.unmodifiable(_favorites)));
  }
}
