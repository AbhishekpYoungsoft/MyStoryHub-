import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/album.dart';
import 'package:mystoryhub/config/api/url_endpoints.dart';
import 'package:mystoryhub/data/network/network_api_services.dart';

class ALbumBloc extends Bloc<AlbumEvents, AlbumStates> {
  ALbumBloc() : super(AlbumLoadingState()) {
    on<LoadAlbumDataEvent>((event, emit) => loadAlbumDataEvent(event, emit));
  }

  loadAlbumDataEvent(
      LoadAlbumDataEvent event, Emitter<AlbumStates> emit) async {
    emit(AlbumLoadingState());
    NetworkApiServices networkApiServices = NetworkApiServices();

    try {
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
    } catch (error) {
      debugPrint("Error: $error");
      emit(AlbumErrorState(error: error.toString()));
    }
  }

}
