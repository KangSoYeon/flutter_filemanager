import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/mock_app_data_source.dart';
import '../../data/datasources/mock_file_local_data_source.dart';
import '../../data/repositories/app_repository_impl.dart';
import '../../data/repositories/file_repository_impl.dart';
import '../../data/repositories/storage_repository_impl.dart';
import '../../domain/entities/app_entity.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/storage_device.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/app_repository.dart';
import '../../domain/repositories/file_repository.dart';
import '../../domain/repositories/storage_repository.dart';
import '../../domain/usecases/get_apps_use_case.dart';
import '../../domain/usecases/get_files_use_case.dart';
import '../../domain/usecases/get_storage_devices_use_case.dart';
import '../../domain/usecases/get_storage_usage_use_case.dart';

// --- 데이터 소스 프로바이더 ---
final mockFileDataSourceProvider = Provider((ref) => MockFileLocalDataSource());
final mockAppDataSourceProvider = Provider((ref) => MockAppDataSource()); // 신규

// --- 리포지토리 프로바이더 ---
final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepositoryImpl(ref.watch(mockFileDataSourceProvider));
});
final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepositoryImpl(ref.watch(mockFileDataSourceProvider));
});
final appRepositoryProvider = Provider<AppRepository>((ref) {
  // 신규
  return AppRepositoryImpl(ref.watch(mockAppDataSourceProvider));
});

// --- 유스케이스 프로바이더 ---
final getStorageDevicesUseCaseProvider = Provider(
  (ref) => GetStorageDevicesUseCase(ref.watch(storageRepositoryProvider)),
);
final getFilesUseCaseProvider = Provider(
  (ref) => GetFilesUseCase(ref.watch(fileRepositoryProvider)),
);
final getStorageUsageUseCaseProvider = Provider(
  (ref) => GetStorageUsageUseCase(ref.watch(storageRepositoryProvider)),
);
final getAppsUseCaseProvider = Provider(
  (ref) => GetAppsUseCase(ref.watch(appRepositoryProvider)),
); // 신규

// --- UI 상태 프로바이더 ---
// 파일 관리자
final storageDevicesProvider = FutureProvider<List<StorageDevice>>(
  (ref) => ref.watch(getStorageDevicesUseCaseProvider).call(),
);
final selectedStorageIdProvider = StateProvider<String?>((ref) => null);
final fileListProvider = FutureProvider.family<List<FileEntity>, String>(
  (ref, storageId) => ref.watch(getFilesUseCaseProvider).call(storageId),
);
final storageUsageProvider = FutureProvider.family<StorageUsage, String>(
  (ref, storageId) => ref.watch(getStorageUsageUseCaseProvider).call(storageId),
);

// 앱 관리자 (신규)
final appListProvider = FutureProvider<List<AppEntity>>(
  (ref) => ref.watch(getAppsUseCaseProvider).call(),
);
