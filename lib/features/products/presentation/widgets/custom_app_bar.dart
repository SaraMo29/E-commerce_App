import 'package:flutter/material.dart';
import 'app_bar_action.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<AppBarAction> actions;

  const CustomAppBar({super.key, required this.title, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
  onPressed: () {
    Navigator.pop(context);
  },
  icon: const Icon(Icons.arrow_back),
),
      title: Text(title),
      actions: actions.map((action) {
        return IconButton(onPressed: action.onPressed, icon: Icon(action.icon));
      }).toList(),
    );
  }
}
