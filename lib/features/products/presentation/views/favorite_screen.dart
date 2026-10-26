import 'package:e_commerce/features/products/presentation/view_models/favorite_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/favorite_state.dart';
import 'package:e_commerce/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/products/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorite Product'),
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final products = context.read<FavoriteCubit>().favorites;

            if (products.isEmpty) {
              return const Center(child: Text('No favorite products yet'));
            }

            return CustomScrollView(
              slivers: [
                ProductsGrid(
                  products: products,
                  onDelete: (product) {
                    context.read<FavoriteCubit>().removeFavorite(product);
                  },
                  onTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailsScreen(productId: product.id),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
