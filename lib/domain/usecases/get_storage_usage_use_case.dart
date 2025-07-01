// lib/domain/usecases/get_storage_usage_use_case.dart

import '../entities/storage_usage.dart';
import '../repositories/storage_repository.dart';

/// 스토리지 사용량 정보를 가져오는 비즈니스 로직
class GetStorageUsageUseCase {
  final StorageRepository repository;
  GetStorageUsageUseCase(this.repository);

  Future<StorageUsage> call(String storageId) async {
    return repository.getStorageUsage(storageId);
  }
}
