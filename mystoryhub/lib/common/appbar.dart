import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key, required this.backgroundColor, required this.title, required this.backButton});
  final Color backgroundColor;
  final String title;
  final bool backButton;
  @override
  Widget build(BuildContext context){
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(title, style:Theme.of(context).textTheme.titleMedium!.copyWith() ,),
       leading: backButton? IconButton(onPressed: ()=> Navigator.pop(context),
      icon:  const Icon(Icons.arrow_back_ios_new),
      ): null,
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}