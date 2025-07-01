import 'package:flutter/material.dart';
import 'app_manager_screen.dart';
import 'file_manager_screen.dart';
import '../widgets/home_menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('스토리지 매니저')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            HomeMenuCard(
              title: '파일 관리자',
              icon: Icons.folder_copy,
              color: Colors.amber,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FileManagerScreen(),
                  ),
                );
              },
            ),
            HomeMenuCard(
              title: '앱 관리자',
              icon: Icons.apps,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppManagerScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
