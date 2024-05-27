import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/album.dart';
import 'package:mystoryhub/business_logic/model/album_details.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';
import 'package:mystoryhub/utils/local_storage/storage.dart';

class ALbumBloc extends Bloc<AlbumEvents, AlbumStates> {
  ALbumBloc() : super(AlbumLoadingState()) {
    on<LoadAlbumDataEvent>((event, emit) => loadAlbumDataEvent(event, emit));
    on<LoadAlbumPhotosEvent>(
        (event, emit) => loadAlbumPhotosEvent(event, emit));
  }

  loadAlbumDataEvent(
      LoadAlbumDataEvent event, Emitter<AlbumStates> emit) async {
    emit(AlbumLoadingState());

    try {
      // Initialize local storage
      Storage storage = Storage();
      // Check if user data exists in local storage
      List<Album>? albums = await storage.getAlbums();
      debugPrint(albums.toString());
      if (albums != null) {
        emit(AlbumLoadedState(albums: albums));
      } else {
        NetworkApiServices networkApiServices = NetworkApiServices();
        dynamic responseData = await networkApiServices
            .getGetApiResponse('${AppUrls.albumsUrl}?userId=1');
        debugPrint("Response data : $responseData");

        // Since responseData is a list, handle it accordingly
        if (responseData is List && responseData.isNotEmpty) {
          List<Album> albums =
              responseData.map<Album>((json) => Album.fromJson(json)).toList();
          emit(AlbumLoadedState(albums: albums));
        } else {
          emit(AlbumErrorState(error: "No user data found"));
        }
      }
    } catch (error) {
      debugPrint("Error: $error");
      emit(AlbumErrorState(error: error.toString()));
    }
  }

  loadAlbumPhotosEvent(LoadAlbumPhotosEvent event, Emitter<AlbumStates> emit) async {
    emit(PhotosLoadingState());
    NetworkApiServices networkApiServices = NetworkApiServices();
 
    try {
        // Initialize local storage
      Storage storage = Storage();
      // Check if user data exists in local storage
      List<Album>? albums = await storage.getAlbums();
      debugPrint(albums.toString());
      if (albums != null) {
        emit(AlbumLoadedState(albums: albums));
      }else{
        List<int> albumIdList = [];


      // Collect all post IDs
      for (var album in event.albums) {
        if (album.id != 0) {
          albumIdList.add(album.id);
        }
      }

      // Create a map to hold the comments for each post
      Map<int, List<Photo>> photosMap = {};

      // Fetch comments for each post and store in the map
      for (int id in albumIdList) {
        debugPrint('${AppUrls.commentsUrl}?albumId=$id');
        dynamic responseData = await networkApiServices
            .getGetApiResponse('${AppUrls.photosUrl}?albumId=$id');
        debugPrint("Response data photos for albumId $id: $responseData");

        if (responseData is List) {
          List<Photo> photos =
              responseData.map<Photo>((json) => Photo.fromJson(json)).toList();
          debugPrint("photos: ${photos.length}");
          photosMap[id] = photos;
        } else {
          photosMap[id] = [];
          debugPrint("No photos data found for postId $id");
        }
      }

      // Update each post with its respective comments
      List<Album> updatedAlbums = event.albums.map((post) {
        if (photosMap.containsKey(post.id)) {
          return post.copyWith(photos: photosMap[post.id]);
        } else {
          return post;
        }
      }).toList();

      // Save the albums data to local storage
        await storage.saveAlbums(updatedAlbums);

      emit(AlbumLoadedState(albums: updatedAlbums));
      }

      
    } catch (error) {
      emit(AlbumErrorState(error: error.toString()));
      debugPrint("Error fetching comments for postId : $error");
    }
  }
}
