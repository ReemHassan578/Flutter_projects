import 'package:json_annotation/json_annotation.dart';
part 'rental_duration_model.g.dart';



@JsonSerializable()
class RentalDuration {
  final String unit;
  final int count;

  RentalDuration({required this.unit, required this.count});

  factory RentalDuration.fromJson(Map<String, dynamic> json) =>
      _$RentalDurationFromJson(json);
}
