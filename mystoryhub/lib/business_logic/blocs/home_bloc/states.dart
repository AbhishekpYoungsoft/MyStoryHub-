import 'package:image_picker/image_picker.dart';
import 'package:mystoryhub/business_logic/model/user.dart';

abstract class HomeStates{}

class HomeInitilState extends HomeStates{}

class HomeLoadingState extends HomeStates{}

class HomeLoadedState extends HomeStates{
  final User user;
  String location='pick location';
  final XFile? imageFile;
  HomeLoadedState({required this.user, required this.location, required this.imageFile});
}

class HomeErrorState extends HomeStates{
  String error;
  HomeErrorState({required this.error});

}
