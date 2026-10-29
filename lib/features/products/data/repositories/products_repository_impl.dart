import '../datasources/products_api_datasource.dart';
import '../datasources/reviews_local_datasource.dart';
import '../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsApiDatasource _datasource;
  final ReviewsLocalDatasource _reviewsLocalDatasource;

  ProductsRepositoryImpl({
    required ProductsApiDatasource datasource,
    required ReviewsLocalDatasource reviewsLocalDatasource,
  })  : _datasource = datasource,
        _reviewsLocalDatasource = reviewsLocalDatasource;

  @override
  Future<List<ProductModel>> getProducts({
    int limit = 30,
    int skip = 0,
  }) {
    return _datasource.fetchProducts(limit: limit, skip: skip);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final product = await _datasource.fetchProductById(id);

    await _reviewsLocalDatasource.saveReviews(
      product.id,
      product.reviews,
    );

    return product;
  }

  @override
  Future<List<ProductReview>> getCachedReviews(int productId) {
    return _reviewsLocalDatasource.getReviews(productId);
  }
}