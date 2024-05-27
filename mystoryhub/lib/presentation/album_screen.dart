import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/album.dart';
import 'package:mystoryhub/config/routes/routenames.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    context.read<ALbumBloc>().add(LoadAlbumDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ALbumBloc, AlbumStates>(
      listener: (context, state) {
        if(state is AlbumLoadedState){
          context.read<ALbumBloc>().add(LoadAlbumPhotosEvent(albums: state.albums));
        }
      },
      listenWhen: (previous, current) => (previous is AlbumLoadingState && current is AlbumLoadedState),
      builder: (context, state){
      if (state is AlbumLoadingState || state is PhotosLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoadedState) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 8.0, // Horizontal spacing
                mainAxisSpacing: 20.0, // Vertical spacing
                childAspectRatio: 1.0, // Aspect ratio for the grid items
              ),
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return AlbumGridItem(album: album);
              },
            );
          } else if (state is AlbumErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      );
  }
  }

  //resusable album item widget
  class AlbumGridItem extends StatelessWidget {
  final Album album;

  const AlbumGridItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.albumDetails, arguments: album);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: SizedBox(
                height: 100.sp,
                width: 100.sp,
                child: Image.network(album.photos![0].thumbnailUrl, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.signal_cellular_connected_no_internet_0_bar);
                },),
              ),
            )
          
          ),
          Text(album.title.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith(), maxLines: 5,softWrap: true,overflow: TextOverflow.ellipsis,)

        ],
      ),
    );
  }
}