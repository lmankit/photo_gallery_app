import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery_app/providers/photo/photo_providers.dart';
import 'package:photo_gallery_app/widgets/photo_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    final currentPage = ref.watch(currentPageProvider);
    final totalPages = ref.watch(totalPagesProvider).valueOrNull ?? 1;
    final paginatedPhotosAsync = ref.watch(paginatedPhotosProvider);

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
                ref.read(currentPageProvider.notifier).state = 1;
              },
            ),
          ),
          Expanded(
            child: paginatedPhotosAsync.when(
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
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: AnimatedSmoothIndicator(
                  activeIndex: currentPage - 1,
                  count: totalPages,
                  effect: const WormEffect(),
                  onDotClicked: (index) {
                    ref.read(currentPageProvider.notifier).state = index + 1;
                  },
                ),
              );
            },
          ),
          if (totalPages > 0) Text('Page $currentPage of $totalPages'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
