import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_spacing.dart';
import 'package:e_commerce/core/widgets/cash_img.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;

  const ProductImageSlider({
    super.key,
    required this.images,
  });

  @override
  State<ProductImageSlider> createState() =>
      _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    if (images.isEmpty) {
      return Container(
        height: context.responsive(
          mobile: 240.0,
          tablet: 300.0,
          desktop: 360.0,
        ),
        width: double.infinity,
        color: AppColors.surface,
        child: const Icon(
          Icons.image_not_supported_outlined,
          size: 60,
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: context.responsive(
            mobile: 240.0,
            tablet: 300.0,
            desktop: 360.0,
          ),
          width: double.infinity,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                color: AppColors.surface,
                child: AppNetworkImage(
                  url: images[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),

        SizedBox(height: context.spacing.sm),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(
                horizontal: context.spacing.xs,
              ),
              width: currentIndex == index ? 18.0 : 7.0,
              height: 7.0,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: AppRadius.round,
              ),
            );
          }),
        ),
      ],
    );
  }
}
