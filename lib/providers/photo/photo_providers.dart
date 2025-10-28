import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery_app/models/photo.dart';
import 'package:photo_gallery_app/providers/service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_providers.g.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

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
    return photo.description.toLowerCase().contains(query) ||
        photo.location.toLowerCase().contains(query) ||
        photo.createdBy.toLowerCase().contains(query);
  }).toList();
}

// Refresh photos manually
@riverpod
Future<void> refreshPhotos(Ref ref) async {
  return ref.refresh(fetchPhotosProvider.future);
}
