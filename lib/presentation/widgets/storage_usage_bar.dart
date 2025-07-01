// lib/presentation/widgets/storage_usage_bar.dart

import 'package:flutter/material.dart';
import '../../domain/entities/storage_device.dart';
import '../../domain/entities/storage_usage.dart';

/// 스토리지 사용량 프로그레스 바 위젯
class StorageUsageBar extends StatelessWidget {
  final StorageUsage usage;
  final StorageDevice device;

  const StorageUsageBar({super.key, required this.usage, required this.device});

  @override
  Widget build(BuildContext context) {
    final totalUsed = device.usedSpaceGB;
    final totalSpace = device.totalSpaceGB;

    final Map<String, double> usageMap = {
      '이미지': usage.imagesSizeGB,
      '동영상': usage.videosSizeGB,
      '음악': usage.musicSizeGB,
      '문서': usage.documentsSizeGB,
      '기타': usage.othersSizeGB,
    };

    final Map<String, Color> colorMap = {
      '이미지': Colors.blue,
      '동영상': Colors.red,
      '음악': Colors.purple,
      '문서': Colors.green,
      '기타': Colors.orange,
    };

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '저장 공간',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalUsed.toStringAsFixed(1)}GB / ${totalSpace.toStringAsFixed(0)}GB 사용됨',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 12,
                child: Row(
                  children:
                      usageMap.entries.map((entry) {
                        final proportion =
                            totalUsed > 0 ? entry.value / totalUsed : 0;
                        return Expanded(
                          flex: (proportion * 100).toInt(),
                          child: Container(color: colorMap[entry.key]),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children:
                  usageMap.entries.map((entry) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: colorMap[entry.key],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${entry.key} (${entry.value.toStringAsFixed(2)}GB)',
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
