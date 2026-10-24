
import '../../data/models/product_model.dart';

sealed class FavoriteState {
  const FavoriteState();
}

class FavoriteUpdated extends FavoriteState {
  final List<ProductModel> products;

  const FavoriteUpdated(this.products);
}
