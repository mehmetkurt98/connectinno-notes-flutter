import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notes_repository.dart';

class ExtractTodosUseCase {
  final NotesRepository repository;

  ExtractTodosUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String content) async {
    return await repository.extractTodos(content);
  }
}
