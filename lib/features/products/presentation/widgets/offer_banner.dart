
import 'package:flutter/material.dart';

import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/responsive/responsive_context.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/panner_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Super Flash Sale',
                  style: context.textStyles.heading2.copyWith(
                    color: AppColors.background,
                  ),
                ),
                SizedBox(height: context.spacing.xs),
                Text(
                  '50% Off',
                  style: context.textStyles.heading3.copyWith(
                    color: AppColors.background,
                  ),
                ),
                SizedBox(height: context.spacing.sm),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _TimerBox(value: '08'),
                    const _TimerSeparator(),
                    const _TimerBox(value: '34'),
                    const _TimerSeparator(),
                    const _TimerBox(value: '52'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  const _TimerBox({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: context.textStyles.title.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _TimerSeparator extends StatelessWidget {
  const _TimerSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.xs,
      ),
      child: Text(
        ':',
        style: context.textStyles.title.copyWith(
          color: AppColors.background,
        ),
      ),
    );
  }
}
