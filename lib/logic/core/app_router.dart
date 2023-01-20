import 'package:evaluation_project/ui/screens/home/home_screen.dart';
import 'package:evaluation_project/ui/screens/product/product_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case ProductScreen.routeName:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ProductScreen(
            id: id,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
