import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery_app/providers/photo/photo_providers.dart';
import 'package:photo_gallery_app/widgets/photo_card.dart';

class PhotoListScreen extends ConsumerStatefulWidget {
  const PhotoListScreen({super.key});

  @override
  ConsumerState<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends ConsumerState<PhotoListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPhotosAsync = ref.watch(filteredPhotosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search photos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: filteredPhotosAsync.when(
              data: (photos) {
                if (photos.isEmpty) {
                  return const Center(child: Text('No photos found'));
                }
                return ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return PhotoCard(photo: photos[index]);
                  },
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text(error.toString()));
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
