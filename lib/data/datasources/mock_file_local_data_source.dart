// lib/data/datasources/mock_file_local_data_source.dart

import 'dart:math';
import '../../domain/entities/file_entity.dart';
import 'package:flutter/material.dart';

/// Mock 데이터를 제공하는 로컬 데이터 소스
class MockFileLocalDataSource {
  final Random _random = Random();

  // Mock 데이터 생성
  Future<Map<String, dynamic>> getMockData() async {
    // 3개의 폴더와 10개의 아이템 생성
    final List<Map<String, dynamic>> internalFiles = [
      {'name': '카메라', 'type': FileType.folder, 'size': 0},
      {'name': '다운로드', 'type': FileType.folder, 'size': 0},
      {'name': '문서', 'type': FileType.folder, 'size': 0},
      {'name': '가족사진.jpg', 'type': FileType.image, 'size': 3 * 1024 * 1024},
      {'name': '휴가영상.mp4', 'type': FileType.video, 'size': 150 * 1024 * 1024},
      {'name': '보고서.docx', 'type': FileType.document, 'size': 1 * 1024 * 1024},
      {'name': '좋아하는음악.mp3', 'type': FileType.music, 'size': 5 * 1024 * 1024},
      {'name': '풍경.jpg', 'type': FileType.image, 'size': 4 * 1024 * 1024},
      {'name': '강의영상.mp4', 'type': FileType.video, 'size': 250 * 1024 * 1024},
      {'name': '이력서.pdf', 'type': FileType.document, 'size': 512 * 1024},
    ];

    final List<Map<String, dynamic>> sdCardFiles = [
      {'name': '백업', 'type': FileType.folder, 'size': 0},
      {'name': '여행사진', 'type': FileType.folder, 'size': 0},
      {'name': '영화', 'type': FileType.folder, 'size': 0},
      {'name': '바다.jpg', 'type': FileType.image, 'size': 5 * 1024 * 1024},
      {'name': '액션영화.mkv', 'type': FileType.video, 'size': 1200 * 1024 * 1024},
      {'name': '계약서.pdf', 'type': FileType.document, 'size': 2 * 1024 * 1024},
      {'name': '클래식.mp3', 'type': FileType.music, 'size': 8 * 1024 * 1024},
      {'name': '노을.jpg', 'type': FileType.image, 'size': 2 * 1024 * 1024},
      {'name': '드라마.mp4', 'type': FileType.video, 'size': 800 * 1024 * 1024},
      {'name': '자격증.png', 'type': FileType.image, 'size': 1 * 1024 * 1024},
    ];

    double calculateTotalSize(List<Map<String, dynamic>> files) {
      return files.fold<int>(0, (sum, f) => sum + (f['size'] as int)) /
          (1024 * 1024 * 1024);
    }

    final internalUsed = calculateTotalSize(internalFiles);
    final sdUsed = calculateTotalSize(sdCardFiles);

    return {
      'storages': [
        {
          'id': 'internal',
          'name': '내장 메모리',
          'icon': Icons.phone_android,
          'total': 256.0,
          'used': internalUsed,
        },
        {
          'id': 'sd_card',
          'name': 'SD 카드',
          'icon': Icons.sd_card,
          'total': 128.0,
          'used': sdUsed,
        },
      ],
      'files': {'internal': internalFiles, 'sd_card': sdCardFiles},
    };
  }
}
