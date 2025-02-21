import 'package:json_annotation/json_annotation.dart';
part 'image_links_model.g.dart';


@JsonSerializable()
class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({required this.smallThumbnail, required this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);
}

