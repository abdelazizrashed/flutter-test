import 'package:evaluation_project/logic/bloc/home/home_bloc.dart';
import 'package:evaluation_project/ui/screens/home/widgets/home_product_widget.dart';
import 'package:evaluation_project/ui/screens/product/product_screen.dart';
import 'package:evaluation_project/ui/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  static void navigate(BuildContext context) => Navigator.of(context)
      .pushNamedAndRemoveUntil(routeName, (route) => false);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc.get(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Awesome Store"),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeError) {
              return CustomErrorWidget(
                message: state.message,
                onRefresh: () {
                  HomeBloc.get().add(GetHomeDataEvent());
                },
              );
            }
            if (state is HomeNetworkConnectionError) {
              return CustomErrorWidget(
                message: state.message,
                onRefresh: () {
                  HomeBloc.get().add(GetHomeDataEvent());
                },
              );
            }
            if (state is HomeLoaded) {
              final products = state.model.data!.product;
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return HomeProductWidget(
                    product: product,
                    onTap: (productId) {
                      ProductScreen.navigate(context, productId);
                    },
                  );
                },
              );
            }

            return CustomErrorWidget(
              message: "Something went wrong!",
              onRefresh: () {
                HomeBloc.get().add(GetHomeDataEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
