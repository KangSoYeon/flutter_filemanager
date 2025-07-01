// lib/domain/repositories/storage_repository.dart

import '../entities/storage_device.dart';
import '../entities/storage_usage.dart';

/// 스토리지 데이터에 접근하기 위한 계약서(추상 클래스)
abstract class StorageRepository {
  Future<List<StorageDevice>> getStorageDevices();
  Future<StorageUsage> getStorageUsage(String storageId);
}
