import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textStyles.caption;
    const destinations = [
      (icon: Icons.home_outlined, label: 'Home'),
      (icon: Icons.search, label: 'Explore'),
      (icon: Icons.shopping_cart_outlined, label: 'Cart'),
      (icon: Icons.local_offer_outlined, label: 'Offer'),
      (icon: Icons.person_outline, label: 'Account'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSpacing.bottomNavigationBarHeight,
          child: Row(
            children: [
              for (var index = 0; index < destinations.length; index++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          destinations[index].icon,
                          size: 24,
                          color: index == currentIndex
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          destinations[index].label,
                          style: labelStyle.copyWith(
                            color: index == currentIndex
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: index == currentIndex
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
