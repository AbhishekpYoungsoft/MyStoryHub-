import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/model/album.dart';
import 'package:mystoryhub/common/appbar.dart';
import 'package:mystoryhub/constants/colors.dart';

class AlbumDetailsScreen extends StatelessWidget {
  const AlbumDetailsScreen({super.key, required this.album});
  final Album album;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  const CustomAppBar(
          backgroundColor: AppColors.primaryColor,
          title: 'Album Details',
          backButton: true),
          body: ListView.builder(
            itemCount: album.photos!.length,
            itemBuilder:(context, index){
             final photo = album.photos![index];
          return Card(
            margin:  EdgeInsets.all(8.sp),
            child: ListTile(
              leading: Image.network(
                photo.thumbnailUrl,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) { //for handling network errors
                  return const Icon(Icons.signal_cellular_connected_no_internet_0_bar);
                },
              ),
              title: Text(photo.title, style: Theme.of(context).textTheme.bodyMedium,),
            ),
          );
            } ,)
          )  ;
  }
}