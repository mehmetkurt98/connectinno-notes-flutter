// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_extraction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoExtractionRequestImpl _$$TodoExtractionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TodoExtractionRequestImpl(
      content: json['content'] as String,
    );

Map<String, dynamic> _$$TodoExtractionRequestImplToJson(
        _$TodoExtractionRequestImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

_$TodoExtractionResponseImpl _$$TodoExtractionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TodoExtractionResponseImpl(
      hasTodos: json['hasTodos'] as bool,
      todos: (json['todos'] as List<dynamic>).map((e) => e as String).toList(),
      originalContent: json['originalContent'] as String,
    );

Map<String, dynamic> _$$TodoExtractionResponseImplToJson(
        _$TodoExtractionResponseImpl instance) =>
    <String, dynamic>{
      'hasTodos': instance.hasTodos,
      'todos': instance.todos,
      'originalContent': instance.originalContent,
    };
