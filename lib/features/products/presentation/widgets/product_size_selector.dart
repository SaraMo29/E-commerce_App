
import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductSizeSelector extends StatefulWidget {
  const ProductSizeSelector({super.key});

  @override
  State<ProductSizeSelector> createState() =>
      _ProductSizeSelectorState();
}

class _ProductSizeSelectorState extends State<ProductSizeSelector> {
  final List<String> sizes = [
    '6',
    '6.5',
    '7',
    '7.5',
    '8',
    '8.5',
  ];

  String selectedSize = '7';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Size',
            style: context.textStyles.title,
          ),
          SizedBox(height: context.spacing.md),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              separatorBuilder: (_, __) =>
                  SizedBox(width: context.spacing.md),
              itemBuilder: (context, index) {
                final size = sizes[index];
                final isSelected = size == selectedSize;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Container(
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.background,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      size,
                      style: context.textStyles.body.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
