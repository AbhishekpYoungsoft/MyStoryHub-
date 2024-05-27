// post_states.dart
import 'package:mystoryhub/business_logic/model/posts.dart';

abstract class PostStates {}

class PostsLoadingState extends PostStates {}

class PostsLoadedState extends PostStates {
  final List<Post> posts;
  PostsLoadedState({required this.posts});
}

class PostsErrorState extends PostStates {
  final String error;
  PostsErrorState({required this.error});
}

// class CommentsLoadingState extends PostStates {
//   final int postId;
//   CommentsLoadingState({required this.postId});
// }

// class CommentsLoadedState extends PostStates {
//   final int postId;
//   final List<Comment> comments;
//   CommentsLoadedState({required this.postId, required this.comments});
// }
