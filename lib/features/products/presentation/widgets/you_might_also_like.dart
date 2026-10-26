import 'package:e_commerce/core/responsive/responsive_context.dart';
import 'package:e_commerce/features/products/presentation/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_models/products_cubit.dart';
import '../view_models/products_state.dart';
import '../widgets/product_card.dart';
import '../../data/models/product_model.dart';

class YouMightAlsoLike extends StatelessWidget {
  final ProductModel currentProduct;

  const YouMightAlsoLike({super.key, required this.currentProduct});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is! ProductsSuccess) {
          return const SizedBox.shrink();
        }

        final recommendedProducts = state.products
            .where((product) => product.id != currentProduct.id)
            .toList();

        if (recommendedProducts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.all(context.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You Might Also Like', style: context.textStyles.heading4),
              SizedBox(height: context.spacing.md),

              SizedBox(
                height: context.responsive(
                  mobile: 260.0,
                  tablet: 290.0,
                  desktop: 310.0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final recommendedProduct = recommendedProducts[index];

                    return Padding(
                      padding: EdgeInsets.only(right: context.spacing.md),
                      child: SizedBox(
                        width: context.responsive(
                          mobile: 160.0,
                          tablet: 190.0,
                          desktop: 210.0,
                        ),
                        child: ProductCard(
                          product: recommendedProduct,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsScreen(
                                  productId: recommendedProduct.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
