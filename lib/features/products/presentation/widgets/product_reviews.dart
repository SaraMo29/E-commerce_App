
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
              Text(
                'Review Product',
                style: context.textStyles.heading4,
              ),
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
            ...product.reviews.map(
              (review) => Padding(
                padding: EdgeInsets.only(
                  bottom: context.spacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: context.textStyles.title,
                    ),

                    SizedBox(height: context.spacing.sm),

                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.star,
                          size: 18,
                        ),
                      ),
                    ),

                    SizedBox(height: context.spacing.md),

                    Text(
                      review.comment,
                      style: context.textStyles.body,
                    ),

                    SizedBox(height: context.spacing.sm),

                    Text(
                      review.date?.toString().split(' ').first ?? '',
                      style: context.textStyles.caption,
                    ),
                  ],
                ),
              ),
            )
          else
            const Text('No reviews yet'),
        ],
      ),
    );
  }
}
