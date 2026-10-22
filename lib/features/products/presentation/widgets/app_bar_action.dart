
import 'package:flutter/material.dart';

class AppBarAction {
  const AppBarAction({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
}
