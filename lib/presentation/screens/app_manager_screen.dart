import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../widgets/app_list_item.dart';

class AppManagerScreen extends ConsumerWidget {
  const AppManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appListAsync = ref.watch(appListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('앱 관리자')),
      body: appListAsync.when(
        data: (apps) {
          final totalSize =
              apps.fold<double>(0, (sum, app) => sum + app.sizeInMB) / 1024;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '총 앱 사용량',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${totalSize.toStringAsFixed(2)} GB',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  itemCount: apps.length,
                  separatorBuilder:
                      (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return AppListItem(app: apps[index]);
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('앱 목록을 불러올 수 없습니다: $err')),
      ),
    );
  }
}
