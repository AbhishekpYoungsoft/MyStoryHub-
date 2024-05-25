import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mystoryhub/services/base_services.dart';

class AppServices extends BaseAppServices {
  @override
  Future<Position?> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Location services are not enabled, show dialog to enable them
      // This could be a dialog or a snackbar prompting the user to enable location services
      debugPrint("Location services are disabled.");
      // Show dialog or snackbar to inform the user to enable location services
      //return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, request permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show dialog or snackbar explaining why location permissions are necessary
        // This could be a dialog or a snackbar explaining why location permissions are necessary
        debugPrint("Location permissions are denied.");
        // Show dialog or snackbar to explain why location permissions are necessary
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      // This could be a dialog informing the user that location permissions are required and directing them to app settings
      debugPrint("Location permissions are denied forever.");
      // Show dialog informing the user that location permissions are required and direct them to app settings
      await Geolocator.openAppSettings();
      return null;
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device
    return await Geolocator.getCurrentPosition();
  }

 
  @override
  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile;
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile = pickedFile;
      }
    } catch (error) {
      //throw error
      return imageFile;
    }
    return imageFile;
  }

  @override
  Future<XFile?> captureImage() async {
    final picker = ImagePicker();
    XFile? imageFile;
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        imageFile = pickedFile;
      }
    } catch (error) {
      //throw error
      return imageFile;
    }
    return imageFile;
  }



}
