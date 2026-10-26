import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductReviews extends StatelessWidget {
  final ProductModel product;

  const ProductReviews({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Review Product', style: context.textStyles.heading4),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See More',
                  style: context.textStyles.title.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacing.xs),
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < product.rating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: AppColors.star,
                  size: 18,
                );
              }),
              SizedBox(width: context.spacing.sm),
              Text(
                product.rating.toStringAsFixed(1),
                style: context.textStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: context.spacing.xs),
              Text(
                '(${product.reviews.length} Reviews)',
                style: context.textStyles.body,
              ),
            ],
          ),

          SizedBox(height: context.spacing.lg),

          if (product.reviews.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.reviews[0].reviewerName,
                  style: context.textStyles.title,
                ),

                SizedBox(height: context.spacing.sm),

                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < product.reviews[0].rating
                          ? Icons.star
                          : Icons.star_border,
                      color: AppColors.star,
                      size: 18,
                    ),
                  ),
                ),

                SizedBox(height: context.spacing.md),

                Text(
                  product.reviews[0].comment,
                  style: context.textStyles.body,
                ),

                SizedBox(height: context.spacing.md),

                Text(
                  product.reviews[0].date?.toString().split(' ').first ?? '',
                  style: context.textStyles.caption,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
