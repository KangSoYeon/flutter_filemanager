// lib/domain/usecases/get_files_use_case.dart

import '../entities/file_entity.dart';
import '../repositories/file_repository.dart';

/// 파일 목록을 가져오는 비즈니스 로직
class GetFilesUseCase {
  final FileRepository repository;
  GetFilesUseCase(this.repository);

  Future<List<FileEntity>> call(String storageId) async {
    return repository.getFiles(storageId);
  }
}
