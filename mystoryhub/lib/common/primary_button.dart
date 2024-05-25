// import 'package:flutter/material.dart';

// class PrimaryButton extends StatelessWidget {
//   const PrimaryButton({
//     super.key,
//     required this.buttonHeight,
//     required this.buttonWidth,
//     required this.buttonString,
//     required this.buttonColor,
//     required this.textColor

//   });

//   final double buttonHeight;
//   final double buttonWidth;
//   final String buttonString;
//   final Color buttonColor;
//   final Color textColor;

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Container(
//       width: buttonWidth,
//       height: buttonHeight,
//       padding: const EdgeInsets.all( 10),
//       decoration: ShapeDecoration(
//         color: buttonColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       ),
//       child: Center(
//         child: Text(
//           buttonString,
//           style: textTheme.bodyMedium!.copyWith(
//             color: textColor,
//             fontSize: 14,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }
// }
