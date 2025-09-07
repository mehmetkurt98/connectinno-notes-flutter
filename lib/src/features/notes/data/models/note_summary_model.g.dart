// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteSummaryModelImpl _$$NoteSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NoteSummaryModelImpl(
      summary: json['summary'] as String,
      keyPoints:
          (json['keyPoints'] as List<dynamic>).map((e) => e as String).toList(),
      wordCount: (json['wordCount'] as num).toInt(),
      originalWordCount: (json['originalWordCount'] as num).toInt(),
    );

Map<String, dynamic> _$$NoteSummaryModelImplToJson(
        _$NoteSummaryModelImpl instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'keyPoints': instance.keyPoints,
      'wordCount': instance.wordCount,
      'originalWordCount': instance.originalWordCount,
    };

_$NoteSummaryRequestImpl _$$NoteSummaryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NoteSummaryRequestImpl(
      content: json['content'] as String,
    );

Map<String, dynamic> _$$NoteSummaryRequestImplToJson(
        _$NoteSummaryRequestImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
