import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_extraction_model.freezed.dart';
part 'todo_extraction_model.g.dart';

@freezed
class TodoExtractionRequest with _$TodoExtractionRequest {
  const factory TodoExtractionRequest({required String content}) =
      _TodoExtractionRequest;

  factory TodoExtractionRequest.fromJson(Map<String, dynamic> json) =>
      _$TodoExtractionRequestFromJson(json);
}

@freezed
class TodoExtractionResponse with _$TodoExtractionResponse {
  const factory TodoExtractionResponse({
    required bool hasTodos,
    required List<String> todos,
    required String originalContent,
  }) = _TodoExtractionResponse;

  factory TodoExtractionResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoExtractionResponseFromJson(json);
}
