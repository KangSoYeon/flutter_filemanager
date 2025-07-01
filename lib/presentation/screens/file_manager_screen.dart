// lib/presentation/screens/file_manager_screen.dart

import 'package:flutter/material.dart';
import '../widgets/file_explorer_view.dart';
import '../widgets/storage_list_view.dart';

/// 파일 매니저 메인 화면
class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('파일 매니저'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Row(
        children: [
          // 왼쪽 스토리지 목록 패널
          Container(
            width: 250,
            color: const Color(0xFFE8ECF1),
            child: const StorageListView(),
          ),
          // 오른쪽 파일 탐색기 패널
          const Expanded(child: FileExplorerView()),
        ],
      ),
    );
  }
}
