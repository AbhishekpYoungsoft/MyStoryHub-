import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/posts.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';
import 'package:mystoryhub/utils/local_storage/storage.dart';

class PostBloc extends Bloc<PostEvents, PostStates> {
  PostBloc() : super(PostsLoadingState()) {
    on<LoadPostDataEvent>((event, emit) => loadPostDataEvent(event, emit));
    on<LoadCommentsEvent>((event, emit) => loadCommentsEvent(event, emit));
  }

  loadPostDataEvent(LoadPostDataEvent event, Emitter<PostStates> emit) async {
    emit(PostsLoadingState());
    NetworkApiServices networkApiServices = NetworkApiServices();

    try {
      Storage storage = Storage();
      List<Post>? posts = await storage.getPosts();
      if (posts != null) {
        emit(PostsLoadedState(posts: posts));
      } else {
        dynamic responseData = await networkApiServices
            .getGetApiResponse('${AppUrls.postsUrl}?userId=1');
        debugPrint("Response data posts : $responseData");

        if (responseData is List && responseData.isNotEmpty) {
          List<Post> posts =
              responseData.map<Post>((json) => Post.fromJson(json)).toList();
          emit(PostsLoadedState(posts: posts));
        } else {
          emit(PostsErrorState(error: "No posts data found"));
        }
      }
    } catch (error) {
      emit(PostsErrorState(error: error.toString()));
    }
  }

  loadCommentsEvent(LoadCommentsEvent event, Emitter<PostStates> emit) async {
    // Capture the current state to get the posts list
    NetworkApiServices networkApiServices = NetworkApiServices();
      try {
        Storage storage = Storage();
        List<Post>? posts = await storage.getPosts();
        if (posts != null) {
          emit(PostsLoadedState(posts: posts));
        } else {
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
            dynamic responseData = await networkApiServices
                .getGetApiResponse('${AppUrls.commentsUrl}?postId=$id');
            debugPrint("Response data comments for postId $id: $responseData");

            if (responseData is List) {
              List<Comment> comments = responseData
                  .map<Comment>((json) => Comment.fromJson(json))
                  .toList();
              debugPrint("comments: ${comments.length}");
              commentsMap[id] = comments;
            } else {
              commentsMap[id] = []; //add emptu list in place
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

          await storage.savePosts(updatedPosts);//save in local

          emit(PostsLoadedState(posts: updatedPosts));
        }
      } catch (error) {
        emit(PostsErrorState(error: error.toString()));
        debugPrint("Error fetching comments for postId : $error");
      }
  }
}
