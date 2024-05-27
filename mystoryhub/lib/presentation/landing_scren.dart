import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/events.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/states.dart';
import 'package:mystoryhub/common/appbar.dart';
import 'package:mystoryhub/constants/asset_path.dart';
import 'package:mystoryhub/constants/colors.dart';
import 'package:mystoryhub/presentation/album_screen.dart';
import 'package:mystoryhub/presentation/home_screen.dart';
import 'package:mystoryhub/presentation/posts_screen.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: AppColors.primaryColor, title: 'My Story Hub', backButton: false,),
      body: BlocBuilder<LandingBloc, LandingStates>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentIndex,
            children: const [
              HomeScreen(),
              AlbumScreen(),
              PostsScreen()
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<LandingBloc, LandingStates>(
        builder: (context, state) {
          if (state is LandingLoadedState) {
            return BottomNavigationBar(
              iconSize: 40.sp,
              type: BottomNavigationBarType.shifting,
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.greyColor,
              elevation: 0,
              onTap: (index) {
                context
                    .read<LandingBloc>()
                    .add(UpdateBottomNavItemEventItem(index));
              },
              items: [
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.homeIcon,
                  tooltip: 'Profile',
                  active: state.currentIndex == 0,
                  label:  'Profile',
                ),
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.albumIcon,
                  tooltip: 'Album',
                  active: state.currentIndex == 1,
                  label:  'Album',
                ),
                   buildBottomNavigationBarItem(
                  iconPath: AssetPath.socialIcon,
                  tooltip: 'Posts',
                  active: state.currentIndex == 2,
                  label:  'Posts',
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

}

BottomNavigationBarItem buildBottomNavigationBarItem({
  required String iconPath,
  required String tooltip,
  required bool active,
  required String label
}) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      height: 30.sp,
      width: 30.sp,
      child: SvgPicture.asset(
        iconPath,
        color: active?AppColors.primaryColor: AppColors.greyColor,
        fit: BoxFit.contain,
      ),
    ),
    label: label,
    tooltip: tooltip,
  );
}
