import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/model/posts.dart';
import 'package:mystoryhub/common/appbar.dart';
import 'package:mystoryhub/constants/colors.dart';

class PostsDetailsScreen extends StatelessWidget {
  const PostsDetailsScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const CustomAppBar(
          backgroundColor: AppColors.primaryColor,
          title: 'Post Details',
          backButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //post title
              Text(post.title,
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Text(post.body, style: textTheme.bodySmall!.copyWith()),
              SizedBox(height: 8.h),
              const Divider(),
              Text("Comments Section",
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              if (post.comments != null)
                ...post.comments!.map((comment) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //comment section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email  :',
                                style: textTheme.bodySmall!
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                                child: Text(comment.email,
                                    style: textTheme.bodySmall)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('comment:',
                                style: textTheme.bodySmall!
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                                child: Text(
                              comment.body,
                              style: textTheme.bodySmall,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            )),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
