import 'package:flutter/material.dart';

class AppEntity {
  final String id;
  final IconData icon;
  final String name;
  final double sizeInMB;
  final String version;

  AppEntity({
    required this.id,
    required this.icon,
    required this.name,
    required this.sizeInMB,
    required this.version,
  });
}
