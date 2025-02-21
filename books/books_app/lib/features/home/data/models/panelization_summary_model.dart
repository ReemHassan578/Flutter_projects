import 'package:json_annotation/json_annotation.dart';
part 'panelization_summary_model.g.dart';

@JsonSerializable()
class PanelizationSummary {
  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  PanelizationSummary(
      {required this.containsEpubBubbles, required this.containsImageBubbles});
  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      _$PanelizationSummaryFromJson(json);
}

