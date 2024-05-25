import 'package:flutter/material.dart';
import 'package:mystoryhub/config/routes/routenames.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()  {
   
    navToLanding();
    super.initState();
  }

  void navToLanding() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamed(context, RouteNames.landing);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
