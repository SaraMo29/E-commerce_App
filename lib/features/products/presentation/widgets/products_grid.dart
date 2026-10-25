
import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_context.dart';
import '../../data/models/product_model.dart';
import 'product_card.dart';

/// Renders only the products grid as a sliver.
///
/// The parent screen owns page layout and state handling.
/// onDelete is optional and is used when products can be removed,
/// such as in the Favorite screen.
class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(ProductModel product)? onDelete;

  const ProductsGrid({
    super.key,
    required this.products,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.responsive(
            mobile: 2,
            tablet: 4,
            desktop: 6,
          ),
          mainAxisSpacing: context.spacing.md,
          crossAxisSpacing: context.spacing.md,
          childAspectRatio: context.responsive(
            mobile: 0.62,
            tablet: 0.68,
            desktop: 0.72,
          ),
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProductCard(
            product: products[index],
            onDelete: onDelete,
          ),
          childCount: products.length,
        ),
      ),
    );
  }
}
