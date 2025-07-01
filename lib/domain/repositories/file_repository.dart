// lib/domain/repositories/file_repository.dart

import '../entities/file_entity.dart';

/// 파일 데이터에 접근하기 위한 계약서(추상 클래스)
abstract class FileRepository {
  Future<List<FileEntity>> getFiles(String storageId);
}
