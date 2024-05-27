
import 'package:flutter/material.dart';

//resuable custom error widget
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
     required this.errorMsg
  });
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(errorMsg),
    );
  }
}