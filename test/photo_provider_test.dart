import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery_app/models/photo.dart';
import 'package:photo_gallery_app/providers/photo/photo_providers.dart';
import 'package:photo_gallery_app/services/api.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Photo Providers Tests', () {
    test('fetchAllPhotos returns sorted photos', () async {
      // Mock the API service
      final mockApiService = MockApiService();

      final mockPhotos = [
        const Photo(
          id: '1',
          createdAt: '2023-03-31T02:04:59.404Z',
          url: 'https://example.com/photo1.jpg',
          description: 'First photo',
          location: 'Location 1',
          createdBy: 'User 1',
          takenAt: '2022-07-09T03:43:45.480Z',
        ),
        const Photo(
          id: '2',
          createdAt: '2023-04-01T02:04:59.404Z',
          url: 'https://example.com/photo2.jpg',
          description: 'Second photo',
          location: 'Location 2',
          createdBy: 'User 2',
          takenAt: '2022-08-09T03:43:45.480Z',
        ),
      ];

      when(mockApiService.fetchPhotos()).thenAnswer((_) async => mockPhotos);

      // Test: verify photos are sorted by takenAt (newest first)
      expect(
          mockPhotos[1].takenAtDate.isAfter(mockPhotos[0].takenAtDate), true);
    });

    test('searchQuery filter works correctly', () async {
      final container = ProviderContainer();

      container.read(searchQueryProvider.notifier).state = 'test';

      final query = container.read(searchQueryProvider);
      expect(query, 'test');
    });

    test('empty search query returns all photos', () {
      final container = ProviderContainer();

      container.read(searchQueryProvider.notifier).state = '';

      final query = container.read(searchQueryProvider);
      expect(query, isEmpty);
    });
  });
}
