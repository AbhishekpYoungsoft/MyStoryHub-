import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/events.dart';
import 'package:mystoryhub/business_logic/blocs/album_bloc/states.dart';
import 'package:mystoryhub/business_logic/model/album.dart';

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
    return BlocBuilder<ALbumBloc, AlbumStates>(builder: (context, state){
      if (state is AlbumLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoadedState) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 8.0, // Horizontal spacing
                mainAxisSpacing: 8.0, // Vertical spacing
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

  class AlbumGridItem extends StatelessWidget {
  final Album album;

  const AlbumGridItem({required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.folder,
              size: 48.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 8.0),
            Text(
              album.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}