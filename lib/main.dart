// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/file_manager_screen.dart';

void main() {
  runApp(
    // Riverpod를 사용하기 위해 앱 전체를 ProviderScope로 감쌉니다.
    const ProviderScope(child: FileManagerApp()),
  );
}

class FileManagerApp extends StatelessWidget {
  const FileManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '클린 아키텍처 파일 매니저',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        cardColor: Colors.white,
        dividerColor: Colors.grey[200],
      ),
      debugShowCheckedModeBanner: false,
      home: const FileManagerScreen(),
    );
  }
}
