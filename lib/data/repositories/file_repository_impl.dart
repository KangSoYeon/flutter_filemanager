// lib/data/repositories/file_repository_impl.dart

import 'dart:math';
import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/file_repository.dart';
import '../datasources/mock_file_local_data_source.dart';

/// FileRepository의 실제 구현체
class FileRepositoryImpl implements FileRepository {
  final MockFileLocalDataSource dataSource;
  FileRepositoryImpl(this.dataSource);

  @override
  Future<List<FileEntity>> getFiles(String storageId) async {
    final data = await dataSource.getMockData();
    final filesData = (data['files'] as Map)[storageId] as List;

    return filesData
        .map(
          (f) => FileEntity(
            id: '${storageId}_${f['name']}',
            name: f['name'],
            type: f['type'],
            sizeInBytes: f['size'],
            dateModified: DateTime.now().subtract(
              Duration(days: Random().nextInt(30)),
            ),
          ),
        )
        .toList();
  }
}
