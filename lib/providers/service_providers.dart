import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery_app/services/api.dart';
import 'package:photo_gallery_app/services/database.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());