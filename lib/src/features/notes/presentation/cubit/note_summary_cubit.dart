import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/note_summary.dart';
import '../../domain/usecases/summarize_note_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger_mixin.dart';

// States
abstract class NoteSummaryState extends Equatable {
  const NoteSummaryState();

  @override
  List<Object?> get props => [];
}

class NoteSummaryInitial extends NoteSummaryState {}

class NoteSummaryLoading extends NoteSummaryState {}

class NoteSummaryLoaded extends NoteSummaryState {
  final NoteSummary summary;

  const NoteSummaryLoaded(this.summary);

  @override
  List<Object?> get props => [summary];
}

class NoteSummaryError extends NoteSummaryState {
  final String message;

  const NoteSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class NoteSummaryCubit extends Cubit<NoteSummaryState> with LoggerMixin {
  final SummarizeNoteUsecase _summarizeNoteUsecase;

  NoteSummaryCubit({required SummarizeNoteUsecase summarizeNoteUsecase})
    : _summarizeNoteUsecase = summarizeNoteUsecase,
      super(NoteSummaryInitial()) {
    initLogger();
  }

  Future<void> summarizeNote(String content) async {
    if (content.trim().isEmpty) {
      logWarning('⚠️ Özetleme isteği: İçerik boş');
      emit(const NoteSummaryError('İçerik boş olamaz'));
      return;
    }

    if (content.trim().length < 10) {
      logWarning(
        '⚠️ Özetleme isteği: İçerik çok kısa (${content.trim().length} karakter)',
      );
      emit(const NoteSummaryError('Özetleme için en az 10 karakter gerekli'));
      return;
    }

    logInfo('🤖 AI özetleme başlatılıyor (${content.trim().length} karakter)');
    emit(NoteSummaryLoading());

    final result = await _summarizeNoteUsecase(content);

    result.fold(
      (failure) {
        String message = 'Bilinmeyen hata';
        if (failure is NetworkFailure) {
          message = 'İnternet bağlantısı gerekli';
        } else if (failure is ServerFailure) {
          message = failure.message;
        } else if (failure is ValidationFailure) {
          message = failure.message;
        }
        logError('❌ AI özetleme hatası: $message');
        emit(NoteSummaryError(message));
      },
      (summary) {
        logInfo(
          '✅ AI özetleme başarılı: ${summary.wordCount} kelime -> ${summary.originalWordCount} kelime',
        );
        emit(NoteSummaryLoaded(summary));
      },
    );
  }

  void clearSummary() {
    emit(NoteSummaryInitial());
  }
}
