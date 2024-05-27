
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/states.dart';
import 'package:mystoryhub/common/error.dart';
import 'package:mystoryhub/config/routes/routenames.dart';
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(LoadPostDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostBloc, PostStates>(
        listener: (context, state) {
          if(state is PostsLoadedState){
            context.read<PostBloc>().add(LoadCommentsEvent(posts: state.posts,));
          }
          
        },
        listenWhen: (previous, current)=>(previous is PostsLoadingState && current is PostsLoadedState),
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoadedState) {
            return Padding(
              padding: EdgeInsets.all(8.sp),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.postDetails, arguments: post);
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8.0),
                            Text(post.body),
                            const SizedBox(height: 8.0),
                          ],
                                  ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is PostsErrorState) {
            return CustomErrorWidget(errorMsg: state.error);
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
