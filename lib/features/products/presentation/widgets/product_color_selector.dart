
import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductColorSelector extends StatefulWidget {
  const ProductColorSelector({super.key});

  @override
  State<ProductColorSelector> createState() =>
      _ProductColorSelectorState();
}

class _ProductColorSelectorState
    extends State<ProductColorSelector> {
  final List<Color> colors = [
    const Color(0xFF223263),
    const Color(0xFF40BFFF),
    const Color(0xFFFB7181),
    const Color(0xFF53D1B6),
    const Color(0xFFFFC833),
  ];

  int selectedColorIndex = 1;

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
            'Select Color',
            style: context.textStyles.title,
          ),
          SizedBox(height: context.spacing.md),
          Row(
            children: List.generate(colors.length, (index) {
              final color = colors[index];
              final isSelected = index == selectedColorIndex;

              return Padding(
                padding: EdgeInsets.only(
                  right: context.spacing.md,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
