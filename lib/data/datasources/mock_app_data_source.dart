import 'dart:math';
import 'package:flutter/material.dart';

class MockAppDataSource {
  Future<List<Map<String, dynamic>>> getMockApps() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final random = Random();
    final apps = [
      {'name': '메시지', 'icon': Icons.message, 'size': 102.5, 'version': '3.2.1'},
      {
        'name': '카메라',
        'icon': Icons.camera_alt,
        'size': 250.0,
        'version': '8.1.0',
      },
      {
        'name': '갤러리',
        'icon': Icons.photo_library,
        'size': 180.2,
        'version': '5.0.3',
      },
      {'name': '지도', 'icon': Icons.map, 'size': 320.8, 'version': '11.2.5'},
      {
        'name': '유튜브',
        'icon': Icons.video_library,
        'size': 450.7,
        'version': '17.3.2',
      },
      {
        'name': '캘린더',
        'icon': Icons.calendar_today,
        'size': 80.1,
        'version': '2.5.0',
      },
      {
        'name': '계산기',
        'icon': Icons.calculate,
        'size': 25.5,
        'version': '1.8.9',
      },
      {
        'name': '시계',
        'icon': Icons.access_time,
        'size': 45.3,
        'version': '7.0.0',
      },
      {'name': '연락처', 'icon': Icons.contacts, 'size': 95.6, 'version': '4.1.2'},
      {
        'name': '음악',
        'icon': Icons.music_note,
        'size': 150.0,
        'version': '9.4.1',
      },
    ];
    return apps;
  }
}
