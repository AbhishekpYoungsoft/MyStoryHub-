import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvgWidget extends StatelessWidget {
  const AssetSvgWidget({
    super.key, required this.iconPath, required this.height, required this.width,
  });
  final String iconPath;
  final double height;
  final double width;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}