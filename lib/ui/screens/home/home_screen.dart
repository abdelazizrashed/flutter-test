import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  static void navigate(BuildContext context) => Navigator.of(context)
      .pushNamedAndRemoveUntil(routeName, (route) => false);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
