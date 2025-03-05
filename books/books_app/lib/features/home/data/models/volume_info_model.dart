import 'package:json_annotation/json_annotation.dart';

import 'image_links_model.dart';
import 'industry_identifiers_model.dart';
import 'panelization_summary_model.dart';
import 'reading_modes_model.dart';
part 'volume_info_model.g.dart';


@JsonSerializable()
class VolumeInfoModel {
  final String title;
  final String? subtitle;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final List<IndustryIdentifiers>? industryIdentifiers;
  final ReadingModes? readingModes;
  final int? pageCount;
  final String printType;
  final List<String>? categories;
  final String maturityRating;
  final bool allowAnonLogging;
  final String contentVersion;
  final PanelizationSummary? panelizationSummary;
  final ImageLinks imageLinks;
  final String language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;

  VolumeInfoModel(
      {required this.title,
       this.subtitle,
       this.authors,
       this.publisher,
       this.publishedDate,
       this.description,
       this.industryIdentifiers,
       this.readingModes,
      required this.pageCount,
      required this.printType,
       this.categories,
      required this.maturityRating,
      required this.allowAnonLogging,
      required this.contentVersion,
       this.panelizationSummary,
       required this.imageLinks,
      required this.language,
      required this.previewLink,
      required this.infoLink,
      required this.canonicalVolumeLink});

  factory VolumeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoModelFromJson(json);
}
