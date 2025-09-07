import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/note_summary.dart';
import '../repositories/notes_repository.dart';

class SummarizeNoteUsecase {
  final NotesRepository repository;

  SummarizeNoteUsecase(this.repository);

  Future<Either<Failure, NoteSummary>> call(String content) async {
    if (content.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'İçerik boş olamaz'));
    }

    if (content.trim().length < 10) {
      return const Left(ValidationFailure(message: 'Özetleme için en az 10 karakter gerekli'));
    }

    return await repository.summarizeNote(content);
  }
}
