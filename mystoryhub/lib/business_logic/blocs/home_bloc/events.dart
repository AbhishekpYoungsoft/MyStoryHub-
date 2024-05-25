import 'package:mystoryhub/business_logic/model/user.dart';

abstract class HomeEvents{}

class LoadDataEvent extends HomeEvents{}

class GetLocationEvent extends HomeEvents{
  User user;
  GetLocationEvent(this.user);
}


class PickImageFromGalleryEvent extends HomeEvents {
  User user;
  String location;
  PickImageFromGalleryEvent(this.user, this.location);

}

class CaptureImageEvent extends HomeEvents {
   User user;
  String location;
  CaptureImageEvent(this.user, this.location);
}