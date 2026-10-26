import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/features/products/presentation/view_models/product_details_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/product_details_state.dart';
import 'package:e_commerce/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:e_commerce/features/products/presentation/widgets/app_bar_action.dart';
import 'package:e_commerce/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_color_selector.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_image_slider.dart';
import 'package:e_commerce/features/products/presentation/view_models/favorite_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/favorite_state.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_reviews.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_size_selector.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_specification.dart';
import 'package:e_commerce/features/products/presentation/widgets/you_might_also_like.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            final title = state is ProductDetailsSuccess
                ? state.product.title
                : 'Product Details';

            return CustomAppBar(
              title: title,
              actions: [
                AppBarAction(icon: Icons.search, onPressed: () {}),
                AppBarAction(icon: Icons.more_vert, onPressed: () {}),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading ||
              state is ProductDetailsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            final images = product.images.isNotEmpty
                ? product.images
                : (product.thumbnail != null && product.thumbnail!.isNotEmpty)
                ? [product.thumbnail!]
                : <String>[];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageSlider(images: images),

                  Padding(
                    padding: EdgeInsets.all(context.spacing.md),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: context.textStyles.heading4,
                          ),
                        ),
                        SizedBox(width: context.spacing.sm),

                        BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, favoriteState) {
                            final favoriteCubit = context.read<FavoriteCubit>();
                            final isFavorite = favoriteCubit.isFavorite(
                              product,
                            );

                            return IconButton(
                              onPressed: () {
                                favoriteCubit.toggleFavorite(product);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              color: AppColors.primary,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.md,
                    ),
                    child: Row(
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
                          style: context.textStyles.body,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.md,
                      vertical: context.spacing.sm,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '\$${(product.price * (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                          style: context.textStyles.price,
                        ),
                        SizedBox(width: context.spacing.sm),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: context.textStyles.oldPrice,
                        ),
                      ],
                    ),
                  ),
                  const ProductSizeSelector(),
                  const SizedBox(height: 24),
                  const ProductColorSelector(),
                  const SizedBox(height: 24),
                  ProductSpecification(product: product),
                  ProductReviews(product: product),
                  YouMightAlsoLike(currentProduct: product),
                  const SizedBox(height: 24),
                  const AddToCartButton(),
                   const SizedBox(height: 24),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
