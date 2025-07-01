// lib/domain/entities/file_entity.dart

import 'package:flutter/material.dart';

/// 파일 타입을 나타내는 열거형
enum FileType { folder, image, video, document, music, unknown }

/// 파일 또는 폴더를 나타내는 핵심 데이터 클래스 (Entity)
class FileEntity {
  final String id;
  final String name;
  final FileType type;
  final int sizeInBytes;
  final DateTime dateModified;

  FileEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.sizeInBytes,
    required this.dateModified,
  });
}
