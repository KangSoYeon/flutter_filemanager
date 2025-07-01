// lib/presentation/widgets/file_list_item.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/file_entity.dart';

/// 파일 목록의 각 아이템 위젯
class FileListItem extends StatelessWidget {
  final FileEntity file;
  const FileListItem({super.key, required this.file});

  IconData _getIconForType(FileType type) {
    switch (type) {
      case FileType.folder:
        return Icons.folder;
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.movie;
      case FileType.music:
        return Icons.music_note;
      case FileType.document:
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _getIconForType(file.type),
        color:
            file.type == FileType.folder ? Colors.amber[700] : Colors.grey[600],
      ),
      title: Text(file.name),
      subtitle: Text(
        file.type == FileType.folder ? '' : _formatBytes(file.sizeInBytes),
      ),
      trailing: Text(
        '${file.dateModified.year}-${file.dateModified.month}-${file.dateModified.day}',
      ),
    );
  }
}
