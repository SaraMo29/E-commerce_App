
import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductSpecification extends StatelessWidget {
  final ProductModel product;

  const ProductSpecification({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specification',
            style: context.textStyles.heading4,
          ),
          SizedBox(height: context.spacing.lg),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Shown',
                  style: context.textStyles.body,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  product.brand ?? 'N/A',
                  style: context.textStyles.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacing.md),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Style',
                  style: context.textStyles.body,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  product.sku,
                  style: context.textStyles.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacing.lg),

          Text(
            'Description',
            style: context.textStyles.heading4,
          ),
          SizedBox(height: context.spacing.sm),
          Text(
            product.description,
            style: context.textStyles.body,
          ),
        ],
      ),
    );
  }
}
