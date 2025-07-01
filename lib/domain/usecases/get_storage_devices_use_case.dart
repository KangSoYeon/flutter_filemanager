// lib/domain/usecases/get_storage_devices_use_case.dart

import '../entities/storage_device.dart';
import '../repositories/storage_repository.dart';

/// 스토리지 장치 목록을 가져오는 비즈니스 로직
class GetStorageDevicesUseCase {
  final StorageRepository repository;
  GetStorageDevicesUseCase(this.repository);

  Future<List<StorageDevice>> call() async {
    return repository.getStorageDevices();
  }
}
