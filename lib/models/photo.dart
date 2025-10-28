import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String id,
    required String createdAt,
    required String url,
    required String description,
    required String location,
    required String createdBy,
    required String takenAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  const Photo._();

  DateTime get takenAtDate => DateTime.parse(takenAt);
  DateTime get createdAtDate => DateTime.parse(createdAt);
}
