import 'package:json_annotation/json_annotation.dart';
part 'all_specialization_response.g.dart';

@JsonSerializable()
class AllSpecializationResponse {
  final String message;
  final List<Data> data;
  final bool status;
  final int code;

  AllSpecializationResponse(
      {required this.message,
      required this.data,
      required this.status,
      required this.code});
  factory AllSpecializationResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSpecializationResponseFromJson(json);
}

@JsonSerializable()
class Data {
  final int id;
  final String name;
  final List<Doctors> doctors;

  Data({required this.id, required this.name, required this.doctors});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Doctors {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;
  final Specialization specialization;
  final City city;
  @JsonKey(name:'appoint_price')
  final int appointPrice;
  @JsonKey(name:'start_time')
  final String startTime;
  @JsonKey(name:'end_time')
  final String endTime;

  Doctors(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.photo,
      required this.gender,
      required this.address,
      required this.description,
      required this.degree,
      required this.specialization,
      required this.city,
      required this.appointPrice,
      required this.startTime,
      required this.endTime});
  factory Doctors.fromJson(Map<String, dynamic> json) => _$DoctorsFromJson(json);

}

@JsonSerializable()
class Specialization {
  final int id;
  final String name;

  Specialization({required this.id, required this.name});
    factory Specialization.fromJson(Map<String, dynamic> json) => _$SpecializationFromJson(json);

}

@JsonSerializable()
class City {
  final int id;
  final String name;
  final Governrate governrate;

  City({required this.id, required this.name, required this.governrate});
      factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

}

@JsonSerializable()
class Governrate {
  final int id;
  final String name;

  Governrate({required this.id, required this.name});
      factory Governrate.fromJson(Map<String, dynamic> json) => _$GovernrateFromJson(json);

}
