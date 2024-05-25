import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/home_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/user.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';
import 'package:mystoryhub/services/app_services.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc() : super(HomeInitilState()) {
    on<LoadDataEvent>((event, emit) => loadDataEvent(event, emit));
    on<GetLocationEvent>((event, emit) => getLocationEvent(event, emit),);
    on<PickImageFromGalleryEvent>((event, emit) => pickImageFromGallery(event, emit));
    on<CaptureImageEvent>((event, emit) => captureImageEvent(event, emit));
  }

  loadDataEvent(LoadDataEvent event, Emitter<HomeStates> emit) async {
  print("Loading");
  emit(HomeLoadingState());
  NetworkApiServices networkApiServices = NetworkApiServices();
  
  try {
    dynamic responseData = await networkApiServices.getGetApiResponse('${AppUrls.profileUrl}?id=1');
    debugPrint("Response data : $responseData");

    // Since responseData is a list, handle it accordingly
    if (responseData is List && responseData.isNotEmpty) {
      User user = User.fromJson(responseData[0]);
      debugPrint("User info : ${user.name}");
      emit(HomeLoadedState(user: user, location: 'pick location', imageFile: null));
    } else {
      emit(HomeErrorState(error: "No user data found"));
    }
  } catch (error) {
    emit(HomeErrorState(error: error.toString()));
  }
}

  getLocationEvent(GetLocationEvent event, Emitter<HomeStates> emit) async{
     AppServices appServices = AppServices();
    try {
      Position? currentPosition = await appServices.getCurrentLocation();
      if (currentPosition != null) {
        debugPrint("${currentPosition.latitude}, ${currentPosition.longitude}");
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        if (placemarks.isNotEmpty) {
          Placemark firstPlacemark = placemarks[0];

          String locality = firstPlacemark.locality ??
              ''; // If locality is null, assign an empty string


          debugPrint('Locality: $locality');
          emit(HomeLoadedState(user: event.user, location: locality, imageFile: null));
        } else {
          //current position null
          emit(HomeLoadedState(user: event.user, location: 'Null', imageFile: null));
        }
      } else {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.deniedForever) {
          emit(HomeLoadedState(user: event.user, location: 'No access given',imageFile: null));
        } else {
          emit(HomeLoadedState(user: event.user, location: 'No access given', imageFile: null));
        }
      }
    } catch (error) {
     emit(HomeErrorState(error: error.toString()));
    }
  }
  
  pickImageFromGallery(PickImageFromGalleryEvent event, Emitter<HomeStates> emit) async{
    AppServices appServices= AppServices();

    try{
      XFile? imageFile;
      imageFile = await appServices.pickImageFromGallery();
      if(imageFile!=null){
        emit(HomeLoadedState(user: event.user, location: event.location, imageFile: imageFile));

      }else{
         emit(HomeLoadedState(user: event.user, location: event.location, imageFile: imageFile));

      }

    }catch(error){
     emit(HomeLoadedState(user: event.user, location: event.location, imageFile: null));

    }
    


  }
  
  captureImageEvent(CaptureImageEvent event, Emitter<HomeStates> emit) async{
     AppServices appServices= AppServices();

    try{
      XFile? imageFile;
      imageFile = await appServices.captureImage();
      if(imageFile!=null){
        emit(HomeLoadedState(user: event.user, location: event.location, imageFile: imageFile));

      }else{
         emit(HomeLoadedState(user: event.user, location: event.location, imageFile: imageFile));

      }

    }catch(error){
     emit(HomeLoadedState(user: event.user, location: event.location, imageFile: null));

    }
  }


}
