import 'package:geolocator/geolocator.dart';

abstract class BaseAppServices{
  //location service
  Future<Position?> getCurrentLocation();

  Future<void> pickImageFromGallery();
  Future<void> captureImage();
 
 
}