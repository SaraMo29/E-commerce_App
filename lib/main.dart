
import 'package:e_commerce/core/services/service_locator.dart';
import 'package:e_commerce/core/widgets/app_bottom_navigation_bar.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce/features/auth/presentation/views/login.dart';
import 'package:e_commerce/features/products/presentation/view_models/favorite_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/products_cubit.dart';
import 'package:e_commerce/features/products/presentation/views/favorite_screen.dart';
import 'package:e_commerce/features/products/presentation/views/offer_screen.dart';
import 'package:e_commerce/features/products/presentation/views/product_details_screen.dart';
import 'package:e_commerce/features/products/presentation/views/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/responsive/responsive_context.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register Dio, DioClient, token storage and all services.
  await configureDependencies();

  // Check whether a cached session exists.
  final isLoggedIn = await getIt<AuthRepository>().isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router = _createRouter(widget.isLoggedIn);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => ProductsCubit()..loadProducts()),
      ],
      child: MaterialApp.router(
        title: 'E-Commerce',
        theme: AppTheme.light,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

GoRouter _createRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: isLoggedIn ? '/home' : '/login',
    redirect: (context, state) async {
      if (state.matchedLocation == '/login') return null;

      final authenticated = await getIt<AuthRepository>().isLoggedIn();
      return authenticated ? null : '/login';
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: AppBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const ProductsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                name: 'explore',
                builder: (context, state) =>
                    const _ComingSoonScreen(title: 'Explore'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                name: 'cart',
                builder: (context, state) =>
                    const _ComingSoonScreen(title: 'Cart'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/offer',
                name: 'offer',
                builder: (context, state) => const OfferScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                name: 'account',
                builder: (context, state) =>
                    const _ComingSoonScreen(title: 'Account'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: '/products/:id',
        name: 'productDetails',
        builder: (context, state) => ProductDetailsScreen(
          productId: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );
}

class _ComingSoonScreen extends StatelessWidget {
  const _ComingSoonScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$title is coming soon',
          style: context.textStyles.body,
        ),
      ),
    );
  }
}
