import 'package:evaluation_project/logic/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product";
  static void navigate(BuildContext context, int id) {
    ProductBloc.get().add(GetProductEvent(id));
    Navigator.of(context).pushNamed(routeName, arguments: id);
  }

  final int id;
  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Screen"),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
