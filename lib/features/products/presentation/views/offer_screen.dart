
import 'package:e_commerce/features/products/presentation/widgets/offer_banner.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/features/products/presentation/widgets/app_bar_action.dart';
import 'package:e_commerce/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/products/presentation/view_models/products_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/products_state.dart';
import 'package:e_commerce/features/products/presentation/widgets/products_grid.dart';
import 'package:e_commerce/features/products/presentation/widgets/products_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_screen.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OfferScreenContent();
  }
}

class _OfferScreenContent extends StatelessWidget {
  const _OfferScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Super Flash Sale',
          actions: [AppBarAction(icon: Icons.search, onPressed: () {})],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.md),
              child: const OfferBanner(),
            ),
          ),

          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return switch (state) {
                ProductsSuccess(:final products) => Builder(
                  builder: (context) {
                    final discountedProducts = products
                        .where((product) => product.hasDiscount)
                        .toList();

                    if (discountedProducts.isEmpty) {
                      return const ProductsEmptySliver();
                    }

                    return ProductsGrid(
                      products: discountedProducts,
                      onTap: (product) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailsScreen(productId: product.id),
                          ),
                        );
                      },
                    );
                  },
                ),

                ProductsEmpty() => const ProductsEmptySliver(),

                ProductsError(:final message) => ProductsErrorSliver(
                  message: message,
                  onRetry: () =>
                      context.read<ProductsCubit>().loadProducts(),
                ),

                ProductsLoading() ||
                ProductsInitial() => const ProductsLoadingSliver(),
              };
            },
          ),
        ],
      ),
    );
  }
}
