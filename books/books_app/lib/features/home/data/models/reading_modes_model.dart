import 'package:json_annotation/json_annotation.dart';
part 'reading_modes_model.g.dart';


@JsonSerializable()
class ReadingModes {
  final bool text;
  final bool image;

  ReadingModes({required this.text, required this.image});

  factory ReadingModes.fromJson(Map<String, dynamic> json) =>
      _$ReadingModesFromJson(json);
}