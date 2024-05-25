import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/posts.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';

class PostBloc extends Bloc<PostsEvents, PostsStates> {
  PostBloc() : super(PostsLoadingState()) {
    on<LoadPostsEvent>((event, emit) => loadPostDataEvent(event, emit));
  }

  loadPostDataEvent(LoadPostsEvent event, Emitter<PostsStates> emit) async {
    emit(PostsLoadingState());
    NetworkApiServices networkApiServices = NetworkApiServices();

    try {
      dynamic responseData = await networkApiServices.getGetApiResponse('${AppUrls.postsUrl}?userId=1');
      debugPrint("Response data posts : $responseData");

      // Since responseData is a list, handle it accordingly
      if (responseData is List && responseData.isNotEmpty) {
        // Decode the response data into a list of Post objects
        List<Post> posts = responseData.map<Post>((json) => Post.fromJson(json)).toList();

        emit(PostsLoadedState(posts: posts));
      } else {
        emit(PostsErrorState(error: "No posts data found"));
      }
    } catch (error) {
      debugPrint("Error: $error");
      emit(PostsErrorState(error: error.toString()));
    }
  }

}