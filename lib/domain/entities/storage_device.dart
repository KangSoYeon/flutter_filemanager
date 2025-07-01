// lib/domain/entities/storage_device.dart

import 'package:flutter/material.dart';

/// 스토리지 장치를 나타내는 Entity
class StorageDevice {
  final String id;
  final String name;
  final IconData icon;
  final double totalSpaceGB;
  final double usedSpaceGB;

  StorageDevice({
    required this.id,
    required this.name,
    required this.icon,
    required this.totalSpaceGB,
    required this.usedSpaceGB,
  });
}
