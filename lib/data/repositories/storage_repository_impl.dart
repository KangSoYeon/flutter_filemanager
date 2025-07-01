// lib/data/repositories/storage_repository_impl.dart

import 'package:flutter/material.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/storage_device.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/storage_repository.dart';
import '../datasources/mock_file_local_data_source.dart';
import 'file_repository_impl.dart';

/// StorageRepository의 실제 구현체
class StorageRepositoryImpl implements StorageRepository {
  final MockFileLocalDataSource dataSource;
  StorageRepositoryImpl(this.dataSource);

  @override
  Future<List<StorageDevice>> getStorageDevices() async {
    final data = await dataSource.getMockData();
    final storagesData = data['storages'] as List;

    return storagesData
        .map(
          (s) => StorageDevice(
            id: s['id'],
            name: s['name'],
            icon: s['icon'],
            totalSpaceGB: s['total'],
            usedSpaceGB: s['used'],
          ),
        )
        .toList();
  }

  @override
  Future<StorageUsage> getStorageUsage(String storageId) async {
    final files = await FileRepositoryImpl(dataSource).getFiles(storageId);
    double images = 0, videos = 0, music = 0, docs = 0, others = 0;

    for (var file in files) {
      double sizeGB = file.sizeInBytes / (1024 * 1024 * 1024);
      switch (file.type) {
        case FileType.image:
          images += sizeGB;
          break;
        case FileType.video:
          videos += sizeGB;
          break;
        case FileType.music:
          music += sizeGB;
          break;
        case FileType.document:
          docs += sizeGB;
          break;
        default:
          others += sizeGB;
          break;
      }
    }
    return StorageUsage(
      imagesSizeGB: images,
      videosSizeGB: videos,
      musicSizeGB: music,
      documentsSizeGB: docs,
      othersSizeGB: others,
    );
  }
}
