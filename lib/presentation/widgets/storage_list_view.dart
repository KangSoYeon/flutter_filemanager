// lib/presentation/widgets/storage_list_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

/// 왼쪽 스토리지 목록 위젯
class StorageListView extends ConsumerWidget {
  const StorageListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageDevicesAsync = ref.watch(storageDevicesProvider);
    final selectedId = ref.watch(selectedStorageIdProvider);

    return storageDevicesAsync.when(
      data: (devices) {
        // 앱 시작 시 첫 번째 스토리지를 자동으로 선택
        if (selectedId == null && devices.isNotEmpty) {
          Future.microtask(
            () =>
                ref.read(selectedStorageIdProvider.notifier).state =
                    devices.first.id,
          );
        }

        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            final isSelected = device.id == selectedId;
            return Material(
              color:
                  isSelected
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  device.icon,
                  color: isSelected ? Colors.blue : Colors.grey[700],
                ),
                title: Text(
                  device.name,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  '${device.usedSpaceGB.toStringAsFixed(1)}GB / ${device.totalSpaceGB.toStringAsFixed(0)}GB',
                ),
                onTap: () {
                  ref.read(selectedStorageIdProvider.notifier).state =
                      device.id;
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('오류 발생: $err')),
    );
  }
}
