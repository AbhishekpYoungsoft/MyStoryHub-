import 'package:mystoryhub/business_logic/model/posts.dart';

abstract class PostsStates{}

class PostsLoadingState extends PostsStates{}

class PostsLoadedState extends PostsStates{
    final List<Post> posts;
    

  PostsLoadedState({required this.posts});
}

class PostsErrorState extends PostsStates{
  final String error;

  PostsErrorState({required this.error});
}