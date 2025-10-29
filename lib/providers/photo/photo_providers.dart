import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery_app/models/photo.dart';
import 'package:photo_gallery_app/providers/service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_providers.g.dart';

const pageSize = 10;

final searchQueryProvider = StateProvider<String>((ref) => '');
final currentPageProvider = StateProvider<int>((ref) => 1);

@riverpod
Future<List<Photo>> fetchPhotos(Ref ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final databaseService = ref.watch(databaseServiceProvider);

  try {
    // Fetch photos from API
    final photos = await apiService.fetchPhotos();

    // Sort by taken date in chronological order
    photos.sort((a, b) => b.takenAtDate.compareTo(a.takenAtDate));

    // Cache photos
    await databaseService.cachePhotos(photos);

    return photos;
  } catch (e) {
    // Try to get cached photos if API fails
    try {
      final cachedPhotos = await databaseService.getCachedPhotos();
      cachedPhotos.sort((a, b) => b.takenAtDate.compareTo(a.takenAtDate));
      if (cachedPhotos.isEmpty) {
        throw Exception(
            'No cached data available. Please check your connection.');
      }
      return cachedPhotos;
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
}

// Filtered photos by search query
@riverpod
Future<List<Photo>> filteredPhotos(Ref ref) async {
  final searchQuery = ref.watch(searchQueryProvider);
  final photos = await ref.watch(fetchPhotosProvider.future);
  if (searchQuery.isEmpty) {
    return photos;
  }
  return photos.where((photo) {
    final query = searchQuery.toLowerCase();
    return photo.location.toLowerCase().contains(query) ||
        photo.createdBy.toLowerCase().contains(query);
  }).toList();
}

// Refresh photos manually
@riverpod
Future<void> refreshPhotos(Ref ref) async {
  ref.invalidate(fetchPhotosProvider);
  await ref.read(fetchPhotosProvider.future);
}

@riverpod
Future<int> totalPages(Ref ref) async {
  final photos = await ref.watch(filteredPhotosProvider.future);
  return (photos.length / pageSize).ceil();
}

@riverpod
Future<List<Photo>> paginatedPhotos(Ref ref) async {
  final currentPage = ref.watch(currentPageProvider);
  final totalPages = await ref.watch(totalPagesProvider.future);
  if (currentPage > totalPages) {
    return [];
  }
  final photos = await ref.watch(filteredPhotosProvider.future);
  return photos.skip((currentPage - 1) * pageSize).take(pageSize).toList();
}
