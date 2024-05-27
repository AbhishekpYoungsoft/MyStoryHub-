import 'package:mystoryhub/business_logic/model/album.dart';

abstract class AlbumEvents{}

class LoadAlbumDataEvent extends AlbumEvents{}

class LoadAlbumPhotosEvent extends AlbumEvents{
  List<Album> albums;
  LoadAlbumPhotosEvent({required this.albums});
}

class OnTapAlbumEvent extends AlbumEvents{}