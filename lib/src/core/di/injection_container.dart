import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../utils/constants.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/notes/data/datasources/notes_local_data_source.dart';
import '../../features/notes/data/datasources/notes_remote_data_source.dart';
import '../../features/notes/data/repositories/notes_repository_impl.dart';
import '../../features/notes/domain/repositories/notes_repository.dart';
import '../../features/notes/data/models/note_model.dart';
import '../../features/notes/data/models/pending_operation_model.dart';
import '../../features/notes/data/models/operation_type.dart';
import '../../features/notes/domain/usecases/summarize_note_usecase.dart';
import '../../features/notes/presentation/cubit/note_summary_cubit.dart';

/// Global service locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Debug: Hive başlatıldı
  print('🗂️ Hive başlatıldı');

  // Register Hive adapters
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(PendingOperationModelAdapter());
  Hive.registerAdapter(OperationTypeAdapter());

  // Open Hive boxes with proper types (sadece açık değilse aç)
  try {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    if (!Hive.isBoxOpen(AppConstants.pendingOpsBoxName)) {
      await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    }
  } catch (e) {
    // Hive cache uyumsuzluğu durumunda cache'i temizle
    print('🔄 Hive cache temizleniyor...');
    await Hive.deleteBoxFromDisk(AppConstants.notesBoxName);
    await Hive.deleteBoxFromDisk(AppConstants.pendingOpsBoxName);

    // Yeniden aç
    await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    print('✅ Hive cache temizlendi ve yeniden oluşturuldu');
  }

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  // External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);

  // Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: sl()),
  );

  // Notes
  sl.registerLazySingleton<NotesRemoteDataSource>(
    () => NotesRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // AI Summary
  sl.registerLazySingleton<SummarizeNoteUsecase>(
    () => SummarizeNoteUsecase(sl()),
  );
  sl.registerFactory<NoteSummaryCubit>(
    () => NoteSummaryCubit(summarizeNoteUsecase: sl()),
  );
}
