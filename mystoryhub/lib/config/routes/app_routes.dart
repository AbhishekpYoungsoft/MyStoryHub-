import 'package:flutter/material.dart';
import 'package:mystoryhub/config/routes/routenames.dart';
import 'package:mystoryhub/presentation/album_details_screen.dart';
import 'package:mystoryhub/presentation/landing_scren.dart';
import 'package:mystoryhub/presentation/posts_details_screen.dart';
import 'package:mystoryhub/presentation/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case RouteNames.postDetails:
      final dynamic args = settings.arguments;
        return MaterialPageRoute(builder: (_) =>  PostsDetailsScreen(post: args,));
       case RouteNames.albumDetails:
      final dynamic args = settings.arguments;
        return MaterialPageRoute(builder: (_) =>  AlbumDetailsScreen(album: args,)); 
      default:
        return MaterialPageRoute(
            builder: (_) => DefaultScreen(
                  routName: settings.name.toString(),
                ));
    }
  }
}

//In any other cases of route errors, the page is navigated to this screen showing error
class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key, required this.routName});
  final String routName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No route found for $routName'),
      ),
    );
  }
}
