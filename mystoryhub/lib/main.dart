import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/posts_bloc/bloc.dart';
import 'package:mystoryhub/config/routes/app_routes.dart';
import 'package:mystoryhub/config/routes/routenames.dart';
import 'package:mystoryhub/config/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/presentation/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          //BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
          BlocProvider<LandingBloc>(create: (_)=> LandingBloc()),
          BlocProvider<HomeBloc>(create: (_)=> HomeBloc()),
          BlocProvider<ALbumBloc>(create: (_)=>ALbumBloc()),
          BlocProvider<PostBloc>(create: (_)=>PostBloc())
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),//default standard mobile pixels size
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
                theme: CustomAppTheme.lightTheme,
                themeMode: ThemeMode.light, 
                onGenerateRoute: AppRoutes.ongenerateRoute,
                initialRoute: RouteNames.splash
                )));
  }
}
