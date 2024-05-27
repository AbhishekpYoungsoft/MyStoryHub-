import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/posts.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';
class PostBloc extends Bloc<PostEvents, PostStates> {
  PostBloc() : super(PostsLoadingState()) {
    on<LoadPostDataEvent>((event, emit) => loadPostDataEvent(event, emit));
    on<LoadCommentsEvent>((event, emit) => loadCommentsEvent(event, emit));
  }

  loadPostDataEvent(LoadPostDataEvent event, Emitter<PostStates> emit) async {
    emit(PostsLoadingState());
    NetworkApiServices networkApiServices = NetworkApiServices();

    try {
      dynamic responseData = await networkApiServices.getGetApiResponse('${AppUrls.postsUrl}?userId=1');
      debugPrint("Response data posts : $responseData");

      if (responseData is List && responseData.isNotEmpty) {
        List<Post> posts = responseData.map<Post>((json) => Post.fromJson(json)).toList();
        List<int> postIdList=[];
        emit(PostsLoadedState(posts: posts));

        // Fetch comments for each post
        for (var post in posts) {
          if (post.id != 0) {
            postIdList.add(post.id);
            
            //add(LoadCommentsEvent(posts: posts,postId: post.id));
          }
          //add(LoadCommentsEvent(posts: posts,postIds: postIdList));

        }
      } else {
        emit(PostsErrorState(error: "No posts data found"));
      }
    } catch (error) {
      debugPrint("Error: $error");
      emit(PostsErrorState(error: error.toString()));
    }
  }

loadCommentsEvent(LoadCommentsEvent event, Emitter<PostStates> emit) async {
  // Capture the current state to get the posts list
  NetworkApiServices networkApiServices = NetworkApiServices();
  if (state is PostsLoadedState) {
    //final posts = (state as PostsLoadedState).posts;

    try {
      List<int> postIdList = [];

      // Collect all post IDs
      for (var post in event.posts) {
        if (post.id != 0) {
          postIdList.add(post.id);
        }
      }

      // Create a map to hold the comments for each post
      Map<int, List<Comment>> commentsMap = {};

      // Fetch comments for each post and store in the map
      for (int id in postIdList) {
        debugPrint('${AppUrls.commentsUrl}?postId=$id');
        dynamic responseData = await networkApiServices.getGetApiResponse('${AppUrls.commentsUrl}?postId=$id');
        debugPrint("Response data comments for postId $id: $responseData");

        if (responseData is List) {
          List<Comment> comments = responseData.map<Comment>((json) => Comment.fromJson(json)).toList();
          debugPrint("comments: ${comments.length}");
          commentsMap[id] = comments;
        } else {
          commentsMap[id]=[];
          debugPrint("No comments data found for postId $id");
        }
      }

      // Update each post with its respective comments
      List<Post> updatedPosts = event.posts.map((post) {
        if (commentsMap.containsKey(post.id)) {
          return post.copyWith(comments: commentsMap[post.id]);
        } else {
          return post;
        }
      }).toList();

      if (updatedPosts.isNotEmpty && updatedPosts[0].comments != null && updatedPosts[0].comments!.isNotEmpty) {
        debugPrint("Updated posts: ${updatedPosts[0].comments![0]}");
      }
      
      emit(PostsLoadedState(posts: updatedPosts));
    } catch (error) {
      debugPrint("Error fetching comments for postId : $error");
    }
  }
}

}
