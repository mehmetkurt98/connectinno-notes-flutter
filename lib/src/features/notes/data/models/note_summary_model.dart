import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/note_summary.dart';

part 'note_summary_model.freezed.dart';
part 'note_summary_model.g.dart';

@freezed
class NoteSummaryModel with _$NoteSummaryModel {
  const factory NoteSummaryModel({
    required String summary,
    required List<String> keyPoints,
    required int wordCount,
    required int originalWordCount,
  }) = _NoteSummaryModel;

  factory NoteSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$NoteSummaryModelFromJson(json);
}

extension NoteSummaryModelExtension on NoteSummaryModel {
  NoteSummary toEntity() {
    return NoteSummary(
      summary: summary,
      keyPoints: keyPoints,
      wordCount: wordCount,
      originalWordCount: originalWordCount,
    );
  }
}

@freezed
class NoteSummaryRequest with _$NoteSummaryRequest {
  const factory NoteSummaryRequest({
    required String content,
  }) = _NoteSummaryRequest;

  factory NoteSummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$NoteSummaryRequestFromJson(json);
}
