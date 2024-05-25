
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/states.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(LoadPostsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<PostBloc, PostsStates>(builder: (context, state){
      if (state is PostsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  margin:  EdgeInsets.symmetric(vertical: 8.sp),
                  elevation: 4.0,
                  child: Padding(
                    padding:  EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: textTheme.titleMedium
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          post.body,
                          style: textTheme.bodyMedium
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PostsErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No data'));
          }
  });
  }
}