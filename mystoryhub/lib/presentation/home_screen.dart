import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/user.dart';
import 'package:mystoryhub/common/error.dart';
import 'package:mystoryhub/common/loader.dart';
import 'package:mystoryhub/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
        if (state is HomeInitilState || state is HomeLoadingState) {
          return const LoaderWidget();
        } else if (state is HomeLoadedState) {
          final user = state.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile photo
                InkWell(
                  onTap: () {
                    showImagePickerOptions(context, user, state.location);
                  },
                  // Image picker and showable
                  child: CircleAvatar(
                    radius: 50.sp,
                    backgroundImage: state.imageFile != null
                        ? FileImage(File(state.imageFile!.path))
                        : null,
                    child: state.imageFile == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                SizedBox(height: 10.h),
                // User name and email
                Text(
                  user.name,
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 5.h),
                Text(
                  user.email,
                  style: textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Location
                InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(GetLocationEvent(user));
                  },
                  child: Text(
                    "📍 ${state.location}",
                    style: textTheme.bodyMedium!
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeErrorState) {
          final String error = state.error;
          return CustomErrorWidget(errorMsg: error);
        } else {
          return const CustomErrorWidget(errorMsg: 'Something went wrong.');
        }
      }),
    );
  }
}

//gallary, camera options
void showImagePickerOptions(BuildContext context, User user, String location) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pick from Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              context
                  .read<HomeBloc>()
                  .add(PickImageFromGalleryEvent(user, location));
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Capture Image'),
            onTap: () {
              Navigator.of(context).pop();
              context.read<HomeBloc>().add(CaptureImageEvent(user, location));
            },
          ),
        ],
      );
    },
  );
}
