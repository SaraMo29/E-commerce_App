
import 'package:e_commerce/core/services/service_locator.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce/features/auth/presentation/views/login.dart';
import 'package:e_commerce/features/products/presentation/view_models/favorite_cubit.dart';
import 'package:e_commerce/features/products/presentation/view_models/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/products/presentation/views/products_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register Dio, DioClient, token storage and all services.
  await configureDependencies();

  // Local-cache-first: skip login when a cached session exists.
  final isLoggedIn = await getIt<AuthRepository>().isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(
          create: (_) => ProductsCubit()..loadProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Commerce',
        theme: AppTheme.light,
        home: isLoggedIn ? const ProductsView() : const LoginView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
