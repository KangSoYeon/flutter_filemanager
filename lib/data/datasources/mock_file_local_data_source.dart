// lib/data/datasources/mock_file_local_data_source.dart

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // 실제 API 통신을 위해 http 패키지를 추가합니다.
import '../../domain/entities/file_entity.dart';

/// 실제 네트워크 API 또는 로컬 DB와 통신하는 데이터 소스입니다.
/// 현재는 Mock 데이터를 반환하지만, 실제 API 연동을 위한 구조와 주석이 포함되어 있습니다.
class MockFileLocalDataSource {
  // 실제 API의 기본 URL을 정의합니다.
  final String _baseUrl = "https://api.yourapp.com/v1";

  /// 서버에서 스토리지 및 파일 데이터를 가져오는 비동기 함수입니다.
  Future<Map<String, dynamic>> getMockData() async {
    // =======================================================================
    // 1. 비동기 API 호출 시뮬레이션 (네트워크 지연을 흉내 냅니다)
    //    실제 API를 연동할 때는 이 부분을 삭제하거나 주석 처리합니다.
    // =======================================================================
    print("네트워크에서 데이터를 가져오는 중... (1.5초 대기)");
    await Future.delayed(const Duration(milliseconds: 1500));

    // =======================================================================
    // 2. 실제 API 호출 (여기에 실제 코드를 작성합니다)
    //    http 패키지를 사용하여 서버에 GET 요청을 보냅니다.
    //    실제 구현 시에는 아래 try-catch 블록의 주석을 해제하고 사용하세요.
    // =======================================================================
    /*
    try {
      // 예시: /storage 엔드포인트에 GET 요청을 보냅니다.
      // 인증이 필요하다면 headers에 토큰 등을 추가해야 합니다.
      final response = await http.get(
        Uri.parse('$_baseUrl/storage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_AUTH_TOKEN', // 필요하다면 인증 토큰 추가
        },
      );

      // 응답 상태 코드가 200 (성공)인지 확인합니다.
      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받았다면, JSON 문자열을 Map 형태로 파싱하여 반환합니다.
        // 서버의 응답 구조에 맞춰 아래 return 문을 수정해야 합니다.
        print("API로부터 데이터 수신 성공!");
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        // 서버에서 오류 응답이 온 경우 (예: 404 Not Found, 500 Server Error)
        print("API 에러: ${response.statusCode}");
        throw Exception('API로부터 데이터를 가져오는데 실패했습니다.');
      }
    } catch (e) {
      // 네트워크 연결 오류 등 http 요청 자체에 실패한 경우
      print("네트워크 에러: $e");
      throw Exception('네트워크 연결에 실패했습니다.');
    }
    */

    // =======================================================================
    // 3. (임시) Mock 데이터 반환
    //    위의 실제 API 호출 코드를 주석 처리하는 동안, 이 부분이 대신 실행됩니다.
    //    API 연동이 완료되면 이 Mock 데이터 부분은 삭제해도 됩니다.
    // =======================================================================
    print("Mock 데이터 반환 완료.");
    final Random random = Random();

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
