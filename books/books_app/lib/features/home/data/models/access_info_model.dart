import 'package:json_annotation/json_annotation.dart';

import 'epub_model.dart';
part 'access_info_model.g.dart';


@JsonSerializable()
class AccessInfoModel {
  final String country;
  final String viewability;
  final bool embeddable;
  final bool publicDomain;
  final String textToSpeechPermission;
  final Epub epub;
  final Epub pdf;
  final String webReaderLink;
  final String accessViewStatus;
  final bool quoteSharingAllowed;

  AccessInfoModel(
      {required this.country,
      required this.viewability,
      required this.embeddable,
      required this.publicDomain,
      required this.textToSpeechPermission,
      required this.epub,
      required this.pdf,
      required this.webReaderLink,
      required this.accessViewStatus,
      required this.quoteSharingAllowed});

  factory AccessInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoModelFromJson(json);
}
