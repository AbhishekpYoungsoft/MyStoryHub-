import 'package:mystoryhub/business_logic/model/album.dart';

abstract class AlbumStates{}

class AlbumLoadingState extends AlbumStates{}

class AlbumLoadedState extends AlbumStates{
  List<Album> albums;
  AlbumLoadedState({required this.albums});
}

class AlbumErrorState extends AlbumStates{
  String error;
  AlbumErrorState({required this.error});
}
