import 'package:flutter/material.dart';
import 'package:mystoryhub/common/asset_svg.dart';

class CustomAlerts{
  static void showSnackBar(BuildContext context, String errorText, String iconPath) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AssetSvgWidget(height: 24, width: 24,iconPath:iconPath,),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(errorText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}