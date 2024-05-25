import 'package:mystoryhub/utils/local_storage/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage{
Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // save user profile
  Future<void> saveUser()async{
     final prefs = await _getPrefs();
  }

  //save photos

  //save posts

  //save comments
  
  }