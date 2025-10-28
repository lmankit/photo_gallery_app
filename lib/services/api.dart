import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_gallery_app/models/photo.dart';

class ApiService {
  static const String baseUrl =
      'https://qchkdevhiring.blob.core.windows.net/mobile/api/photos';

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching photos: $e');
    }
  }
}
