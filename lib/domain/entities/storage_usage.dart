// lib/domain/entities/storage_usage.dart

/// 스토리지 사용량 상세 정보를 나타내는 Entity
class StorageUsage {
  final double imagesSizeGB;
  final double videosSizeGB;
  final double musicSizeGB;
  final double documentsSizeGB;
  final double othersSizeGB;

  StorageUsage({
    required this.imagesSizeGB,
    required this.videosSizeGB,
    required this.musicSizeGB,
    required this.documentsSizeGB,
    required this.othersSizeGB,
  });
}
