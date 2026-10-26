
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_context.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddToCartButton({
    super.key,
    this.onPressed,
  });

 
@override
Widget build(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 343,
      height: 57,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary,
  foregroundColor: Colors.white,
  disabledBackgroundColor: AppColors.primary,
  disabledForegroundColor: Colors.white,
  elevation: 0,
  padding: const EdgeInsets.all(16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
),
        child: const Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

}
