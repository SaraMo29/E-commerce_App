import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_bar_action.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<AppBarAction> actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(title),
      actions: actions.map((action) {
        return IconButton(onPressed: action.onPressed, icon: Icon(action.icon));
      }).toList(),
    );
  }
}
