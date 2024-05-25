import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key, required this.imagePath, required this.height, required this.width,
  });
  final String imagePath;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath, 
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error_outline);
      },
      );
  }
}