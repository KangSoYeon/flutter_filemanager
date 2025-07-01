// lib/presentation/providers/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/mock_file_local_data_source.dart';
import '../../data/repositories/file_repository_impl.dart';
import '../../data/repositories/storage_repository_impl.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/storage_device.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/file_repository.dart';
import '../../domain/repositories/storage_repository.dart';
import '../../domain/usecases/get_files_use_case.dart';
import '../../domain/usecases/get_storage_devices_use_case.dart';
import '../../domain/usecases/get_storage_usage_use_case.dart';

// --- 의존성 주입(DI)을 위한 Provider들 ---
final mockDataSourceProvider = Provider((ref) => MockFileLocalDataSource());

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepositoryImpl(ref.watch(mockDataSourceProvider));
});

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepositoryImpl(ref.watch(mockDataSourceProvider));
});

final getStorageDevicesUseCaseProvider = Provider((ref) {
  return GetStorageDevicesUseCase(ref.watch(storageRepositoryProvider));
});

final getFilesUseCaseProvider = Provider((ref) {
  return GetFilesUseCase(ref.watch(fileRepositoryProvider));
});

final getStorageUsageUseCaseProvider = Provider((ref) {
  return GetStorageUsageUseCase(ref.watch(storageRepositoryProvider));
});

// --- UI 상태를 위한 Provider들 ---
final storageDevicesProvider = FutureProvider<List<StorageDevice>>((ref) {
  return ref.watch(getStorageDevicesUseCaseProvider).call();
});

final selectedStorageIdProvider = StateProvider<String?>((ref) => null);

final fileListProvider = FutureProvider.family<List<FileEntity>, String>((
  ref,
  storageId,
) {
  return ref.watch(getFilesUseCaseProvider).call(storageId);
});

final storageUsageProvider = FutureProvider.family<StorageUsage, String>((
  ref,
  storageId,
) {
  return ref.watch(getStorageUsageUseCaseProvider).call(storageId);
});
