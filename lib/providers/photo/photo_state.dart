import 'package:photo_gallery_app/models/photo.dart';

class PhotoState {
  final List<Photo> photos;
  final List<Photo> filteredPhotos;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  PhotoState({
    required this.photos,
    required this.filteredPhotos,
    required this.searchQuery,
    required this.isLoading,
    this.errorMessage,
  });

  PhotoState copyWith({
    List<Photo>? photos,
    List<Photo>? filteredPhotos,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PhotoState(
      photos: photos ?? this.photos,
      filteredPhotos: filteredPhotos ?? this.filteredPhotos,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
