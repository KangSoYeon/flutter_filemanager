// lib/presentation/widgets/file_explorer_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'file_list_item.dart';
import 'storage_usage_bar.dart';

/// 오른쪽 파일 탐색기 위젯
class FileExplorerView extends ConsumerWidget {
  const FileExplorerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedStorageIdProvider);

    if (selectedId == null) {
      return const Center(child: Text('스토리지를 선택하세요.'));
    }

    final storageDevice = ref
        .watch(storageDevicesProvider)
        .asData
        ?.value
        .firstWhere((d) => d.id == selectedId);
    final storageUsageAsync = ref.watch(storageUsageProvider(selectedId));
    final filesAsync = ref.watch(fileListProvider(selectedId));

    if (storageDevice == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            storageDevice.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          storageUsageAsync.when(
            data:
                (usage) => StorageUsageBar(usage: usage, device: storageDevice),
            loading:
                () => const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                ),
            error: (e, s) => Text('사용량 정보를 가져오지 못했습니다: $e'),
          ),
          const SizedBox(height: 24),
          Text('파일 목록', style: Theme.of(context).textTheme.titleMedium),
          const Divider(height: 24),
          Expanded(
            child: filesAsync.when(
              data:
                  (files) => ListView.builder(
                    itemCount: files.length,
                    itemBuilder:
                        (context, index) => FileListItem(file: files[index]),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('파일 목록을 가져오지 못했습니다: $e'),
            ),
          ),
        ],
      ),
    );
  }
}
