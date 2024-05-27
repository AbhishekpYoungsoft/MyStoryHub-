import 'dart:convert';
import 'package:mystoryhub/business_logic/model/album.dart';
import 'package:mystoryhub/business_logic/model/posts.dart';
import 'package:mystoryhub/business_logic/model/user.dart';
import 'package:mystoryhub/utils/local_storage/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // save user profile
  Future<void> saveUser(User user) async {
    final prefs = await _getPrefs();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(SharedPrefsKeys.user, userJson);
  }

  // Get user
  Future<User?> getUser() async {
    final prefs = await _getPrefs();
    String? userJson = prefs.getString(SharedPrefsKeys.user);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  //save albums
 Future<void> saveAlbums(List<Album> albums) async {
    final prefs = await _getPrefs();
    List<Map<String, dynamic>> albumsJson = albums.map((album) => album.toJson()).toList();
    String encodedAlbums = jsonEncode(albumsJson);
    await prefs.setString(SharedPrefsKeys.albums, encodedAlbums);
  }

  //get albums
  Future<List<Album>?> getAlbums() async {
    final prefs = await _getPrefs();
    String? albumsJson = prefs.getString(SharedPrefsKeys.albums);
    if (albumsJson != null) {
      List<dynamic> albumsList = jsonDecode(albumsJson);
      List<Album> albums = albumsList.map((albumJson) => Album.fromJson(albumJson)).toList();
      return albums;
    }
    return null;
  }
  //save posts
  Future<void> savePosts(List<Post> posts) async {
    final prefs = await _getPrefs();
    List<Map<String, dynamic>> postsJson = posts.map((post) => post.toJson()).toList();
    String encodedPosts = jsonEncode(postsJson);
    await prefs.setString(SharedPrefsKeys.posts, encodedPosts);
  }

  //get posts
  Future<List<Post>?> getPosts() async {
    final prefs = await _getPrefs();
    String? postsJson = prefs.getString(SharedPrefsKeys.posts);
    if (postsJson != null) {
      List<dynamic> postsList = jsonDecode(postsJson);
      List<Post> posts = postsList.map((postJson) => Post.fromJson(postJson)).toList();
      return posts;
    }
    return null;
  }
}
