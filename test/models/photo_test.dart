import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery_app/models/photo.dart';

void main() {
  group('Photo Model Tests', () {
    test('Photo.fromJson creates valid Photo object', () {
      final json = {
        'id': '1',
        'createdAt': '2021-01-01',
        'url': 'https://example.com/photo.jpg',
        'description': 'A test photo',
        'location': 'Test Location',
        'createdBy': 'Test User',
        'takenAt': '2021-01-01',
      };
      final photo = Photo.fromJson(json);
      expect(photo.id, '1');
      expect(photo.createdAt, '2021-01-01');
      expect(photo.url, 'https://example.com/photo.jpg');
      expect(photo.description, 'A test photo');
      expect(photo.location, 'Test Location');
      expect(photo.createdBy, 'Test User');
      expect(photo.takenAt, '2021-01-01');
    });

    test('Photo.toJson should return a valid JSON', () {
      const photo = Photo(
        id: '1',
        createdAt: '2021-01-01',
        url: 'https://example.com/photo.jpg',
        description: 'A test photo',
        location: 'Test Location',
        createdBy: 'Test User',
        takenAt: '2021-01-01',
      );
      final json = photo.toJson();
      expect(json['id'], '1');
      expect(json['createdAt'], '2021-01-01');
      expect(json['url'], 'https://example.com/photo.jpg');
      expect(json['description'], 'A test photo');
      expect(json['location'], 'Test Location');
      expect(json['createdBy'], 'Test User');
      expect(json['takenAt'], '2021-01-01');
    });
  });
}
