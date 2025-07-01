import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/home_screen.dart'; // 시작 화면을 HomeScreen으로 변경

void main() {
  runApp(const ProviderScope(child: FileManagerApp()));
}

class FileManagerApp extends StatelessWidget {
  const FileManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스토리지 매니저',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        cardColor: Colors.white,
        dividerColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7FA),
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // 시작 화면 지정
    );
  }
}
