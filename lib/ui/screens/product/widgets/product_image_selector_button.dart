import 'package:flutter/material.dart';

class ProductImageSelectorButton extends StatelessWidget {
  final Function() onTap;
  final String image;
  const ProductImageSelectorButton(
      {super.key, required this.onTap, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
