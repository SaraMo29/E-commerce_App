import 'package:e_commerce/core/widgets/cash_img.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/responsive/responsive_context.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final void Function(ProductModel product)? onDelete;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.thumbnail ??
        (product.images.isNotEmpty ? product.images.first : null);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: EdgeInsets.all(context.spacing.sm),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: AppRadius.card,
                child: _ProductImage(url: imageUrl),
              ),
            ),
            SizedBox(height: context.spacing.sm),
            Text(
              product.title,
              style: context.textStyles.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.spacing.xs),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.star,
                  size: 14,
                ),
                SizedBox(width: context.spacing.xs),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: context.textStyles.caption,
                ),
                const Spacer(),
                if (!product.inStock)
                  Text(
                    'Out of stock',
                    style: context.textStyles.caption.copyWith(
                      color: AppColors.discount,
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.spacing.xs),
            Text(
              '\$${product.discountedPrice.toStringAsFixed(2)}',
              style: context.textStyles.price,
            ),
            SizedBox(height: context.spacing.xs),
            Row(
              children: [
                Expanded(
                  child: product.hasDiscount
                      ? Row(
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: context.textStyles.oldPrice,
                            ),
                            SizedBox(width: context.spacing.xs),
                            Flexible(
                              child: Text(
                                '${product.discountPercentage.toStringAsFixed(0)}% Off',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.discount,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          product.brand ?? product.category,
                          style: context.textStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                if (onDelete != null) ...[
                  SizedBox(width: context.spacing.xs),
                  IconButton(
                    onPressed: () => onDelete!(product),
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.discount,
                    tooltip: 'Remove from favorites',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String? url;

  const _ProductImage({this.url});

  @override
  Widget build(BuildContext context) {
    return AppNetworkImage(
      url: url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
