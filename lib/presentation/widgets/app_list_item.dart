import 'package:flutter/material.dart';
import '../../domain/entities/app_entity.dart';

class AppListItem extends StatelessWidget {
  final AppEntity app;
  const AppListItem({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(app.icon, color: Colors.grey[600]),
      ),
      title: Text(app.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${app.sizeInMB.toStringAsFixed(1)} MB',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('v${app.version}', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
