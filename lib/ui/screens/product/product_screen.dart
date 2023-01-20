import 'package:evaluation_project/domain/models/product/product_model.dart';
import 'package:evaluation_project/logic/bloc/product/product_bloc.dart';
import 'package:evaluation_project/ui/screens/product/widgets/product_image_selector_button.dart';
import 'package:evaluation_project/ui/widgets/custom_drawer.dart';
import 'package:evaluation_project/ui/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = "/product";
  static void navigate(
    BuildContext context,
    int id,
    String name,
  ) {
    Navigator.of(context).pushNamed(routeName, arguments: [id, name]);
  }

  final int id;
  final String name;
  const ProductScreen({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductImageModel? displayedImage;
  ProductColorModel? selectedColor;
  ProductSizeModel? selectedSize;
  List<ProductSizeModel> sizes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoaded) {
          setState(() {
            displayedImage = state.model.data!.MoreImage.first
                .copyWith(image: state.model.data!.image);
            sizes = state.model.data!.Color.first.Size;
          });
        }
      },
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductError) {
          return CustomErrorWidget(
            message: state.message,
            onRefresh: () => ProductBloc.of(context).add(
              GetProductEvent(widget.id),
            ),
          );
        }
        if (state is ProductNetworkConnectionError) {
          return CustomErrorWidget(
            message: state.message,
            onRefresh: () => ProductBloc.of(context).add(
              GetProductEvent(widget.id),
            ),
          );
        }
        if (state is ProductLoaded) {
          final product = state.model.data!;
          return _buildPageContent(context, product);
        }
        return CustomErrorWidget(
          message: "Something went wrong!",
          onRefresh: () => ProductBloc.of(context).add(
            GetProductEvent(widget.id),
          ),
        );
      },
    );
  }

  Column _buildPageContent(BuildContext context, ProductDataModel product) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        _buildImages(context, product),
        _buildProductInfo(product),
      ],
    );
  }

  Widget _buildProductInfo(ProductDataModel product) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          HtmlWidget(
            product.description,
            textStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildColorAndSizeSelectors(product),
        ],
      ),
    );
  }

  Row _buildColorAndSizeSelectors(ProductDataModel product) {
    return Row(
      children: [
        _buildColorSelector(product),
        const SizedBox(
          width: 10,
        ),
        _buildSizeSelector(product),
      ],
    );
  }

  Container _buildSizeSelector(ProductDataModel product) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        itemBuilder: (context, index) {
          final size = sizes[index];
          return InkWell(
            onTap: () {
              setState(() {
                selectedSize = size;
              });
            },
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: selectedSize?.id == size.id
                    ? Border.all(
                        color: Colors.blue,
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  size.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _buildColorSelector(ProductDataModel product) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.Color.length,
        itemBuilder: (context, index) {
          final color = product.Color[index];
          return InkWell(
            onTap: () {
              final image = product.MoreImage.firstWhere(
                (element) => element.hex == color.hex,
                orElse: () => product.MoreImage.first.copyWith(hex: "-1"),
              );
              if (image.hex != "-1") {
                setState(() {
                  displayedImage = image;
                  sizes = color.Size;
                  selectedColor = color;
                });
              }
            },
            child: Container(
              width: 25,
              height: 25,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: selectedColor?.id == color.id
                    ? Border.all(
                        color: Colors.blue,
                        width: 2,
                      )
                    : null,
                color: Color(
                  int.parse(
                    "ff${color.hex}",
                    radix: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _buildImages(BuildContext context, ProductDataModel product) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              displayedImage!.image,
              fit: BoxFit.cover,
            ),
          ),
          if (product.MoreImage.isNotEmpty)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 70,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: product.MoreImage.length + 1,
                  itemBuilder: (context, index) {
                    ProductImageModel currentImage;
                    if (index >= product.MoreImage.length) {
                      currentImage =
                          product.MoreImage[0].copyWith(image: product.image);
                    } else {
                      currentImage = product.MoreImage[index];
                    }
                    return ProductImageSelectorButton(
                      image: currentImage.image,
                      onTap: () {
                        setState(() {
                          displayedImage = currentImage;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
