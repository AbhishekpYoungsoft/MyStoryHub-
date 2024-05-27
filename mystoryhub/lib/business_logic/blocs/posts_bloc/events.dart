import 'package:mystoryhub/business_logic/model/posts.dart';

abstract class PostEvents {}

class LoadPostDataEvent extends PostEvents {}

class LoadCommentsEvent extends PostEvents {
  final List<Post> posts;
  // final List<int> postIds;
  LoadCommentsEvent({ required this.posts,});
}
