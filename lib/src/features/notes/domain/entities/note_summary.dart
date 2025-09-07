import 'package:equatable/equatable.dart';

class NoteSummary extends Equatable {
  final String summary;
  final List<String> keyPoints;
  final int wordCount;
  final int originalWordCount;

  const NoteSummary({
    required this.summary,
    required this.keyPoints,
    required this.wordCount,
    required this.originalWordCount,
  });

  @override
  List<Object?> get props => [summary, keyPoints, wordCount, originalWordCount];

  @override
  String toString() {
    return 'NoteSummary(summary: $summary, keyPoints: $keyPoints, wordCount: $wordCount, originalWordCount: $originalWordCount)';
  }
}
