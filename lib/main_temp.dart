// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:math';

// // =================================================================
// // main.dart - 앱 시작점
// // =================================================================
// void main() {
//   runApp(
//     // Riverpod를 사용하기 위해 앱 전체를 ProviderScope로 감쌉니다.
//     const ProviderScope(child: FileManagerApp()),
//   );
// }

// class FileManagerApp extends StatelessWidget {
//   const FileManagerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '클린 아키텍처 파일 매니저',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         scaffoldBackgroundColor: const Color(0xFFF5F7FA),
//         cardColor: Colors.white,
//         dividerColor: Colors.grey[200],
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const FileManagerScreen(),
//     );
//   }
// }

// // =================================================================
// // DOMAIN LAYER - 핵심 비즈니스 로직
// // =================================================================

// // --- Entities ---

// /// 파일 타입을 나타내는 열거형
// enum FileType { folder, image, video, document, music, unknown }

// /// 파일 또는 폴더를 나타내는 핵심 데이터 클래스 (Entity)
// class FileEntity {
//   final String id;
//   final String name;
//   final FileType type;
//   final int sizeInBytes;
//   final DateTime dateModified;

//   FileEntity({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.sizeInBytes,
//     required this.dateModified,
//   });
// }

// /// 스토리지 장치를 나타내는 Entity
// class StorageDevice {
//   final String id;
//   final String name;
//   final IconData icon;
//   final double totalSpaceGB;
//   final double usedSpaceGB;

//   StorageDevice({
//     required this.id,
//     required this.name,
//     required this.icon,
//     required this.totalSpaceGB,
//     required this.usedSpaceGB,
//   });
// }

// /// 스토리지 사용량 상세 정보를 나타내는 Entity
// class StorageUsage {
//   final double imagesSizeGB;
//   final double videosSizeGB;
//   final double musicSizeGB;
//   final double documentsSizeGB;
//   final double othersSizeGB;

//   StorageUsage({
//     required this.imagesSizeGB,
//     required this.videosSizeGB,
//     required this.musicSizeGB,
//     required this.documentsSizeGB,
//     required this.othersSizeGB,
//   });
// }

// // --- Repositories (Contracts) ---

// /// 파일 데이터에 접근하기 위한 계약서(추상 클래스)
// abstract class FileRepository {
//   Future<List<FileEntity>> getFiles(String storageId);
// }

// /// 스토리지 데이터에 접근하기 위한 계약서(추상 클래스)
// abstract class StorageRepository {
//   Future<List<StorageDevice>> getStorageDevices();
//   Future<StorageUsage> getStorageUsage(String storageId);
// }

// // --- Use Cases ---

// /// 스토리지 장치 목록을 가져오는 비즈니스 로직
// class GetStorageDevicesUseCase {
//   final StorageRepository repository;
//   GetStorageDevicesUseCase(this.repository);

//   Future<List<StorageDevice>> call() async {
//     return repository.getStorageDevices();
//   }
// }

// /// 파일 목록을 가져오는 비즈니스 로직
// class GetFilesUseCase {
//   final FileRepository repository;
//   GetFilesUseCase(this.repository);

//   Future<List<FileEntity>> call(String storageId) async {
//     return repository.getFiles(storageId);
//   }
// }

// /// 스토리지 사용량 정보를 가져오는 비즈니스 로직
// class GetStorageUsageUseCase {
//   final StorageRepository repository;
//   GetStorageUsageUseCase(this.repository);

//   Future<StorageUsage> call(String storageId) async {
//     return repository.getStorageUsage(storageId);
//   }
// }

// // =================================================================
// // DATA LAYER - 데이터 소스 및 구현
// // =================================================================

// // --- Data Sources ---

// /// Mock 데이터를 제공하는 로컬 데이터 소스
// class MockFileLocalDataSource {
//   final Random _random = Random();

//   // Mock 데이터 생성
//   Future<Map<String, dynamic>> getMockData() async {
//     // 3개의 폴더와 10개의 아이템 생성
//     final List<Map<String, dynamic>> internalFiles = [
//       {'name': '카메라', 'type': FileType.folder, 'size': 0},
//       {'name': '다운로드', 'type': FileType.folder, 'size': 0},
//       {'name': '문서', 'type': FileType.folder, 'size': 0},
//       {'name': '가족사진.jpg', 'type': FileType.image, 'size': 3 * 1024 * 1024},
//       {'name': '휴가영상.mp4', 'type': FileType.video, 'size': 150 * 1024 * 1024},
//       {'name': '보고서.docx', 'type': FileType.document, 'size': 1 * 1024 * 1024},
//       {'name': '좋아하는음악.mp3', 'type': FileType.music, 'size': 5 * 1024 * 1024},
//       {'name': '풍경.jpg', 'type': FileType.image, 'size': 4 * 1024 * 1024},
//       {'name': '강의영상.mp4', 'type': FileType.video, 'size': 250 * 1024 * 1024},
//       {'name': '이력서.pdf', 'type': FileType.document, 'size': 512 * 1024},
//     ];

//     final List<Map<String, dynamic>> sdCardFiles = [
//       {'name': '백업', 'type': FileType.folder, 'size': 0},
//       {'name': '여행사진', 'type': FileType.folder, 'size': 0},
//       {'name': '영화', 'type': FileType.folder, 'size': 0},
//       {'name': '바다.jpg', 'type': FileType.image, 'size': 5 * 1024 * 1024},
//       {'name': '액션영화.mkv', 'type': FileType.video, 'size': 1200 * 1024 * 1024},
//       {'name': '계약서.pdf', 'type': FileType.document, 'size': 2 * 1024 * 1024},
//       {'name': '클래식.mp3', 'type': FileType.music, 'size': 8 * 1024 * 1024},
//       {'name': '노을.jpg', 'type': FileType.image, 'size': 2 * 1024 * 1024},
//       {'name': '드라마.mp4', 'type': FileType.video, 'size': 800 * 1024 * 1024},
//       {'name': '자격증.png', 'type': FileType.image, 'size': 1 * 1024 * 1024},
//     ];

//     double calculateTotalSize(List<Map<String, dynamic>> files) {
//       return files.fold<int>(0, (sum, f) => sum + (f['size'] as int)) /
//           (1024 * 1024 * 1024);
//     }

//     final internalUsed = calculateTotalSize(internalFiles);
//     final sdUsed = calculateTotalSize(sdCardFiles);

//     return {
//       'storages': [
//         {
//           'id': 'internal',
//           'name': '내장 메모리',
//           'icon': Icons.phone_android,
//           'total': 256.0,
//           'used': internalUsed,
//         },
//         {
//           'id': 'sd_card',
//           'name': 'SD 카드',
//           'icon': Icons.sd_card,
//           'total': 128.0,
//           'used': sdUsed,
//         },
//       ],
//       'files': {'internal': internalFiles, 'sd_card': sdCardFiles},
//     };
//   }
// }

// // --- Repository Implementations ---

// /// FileRepository의 실제 구현체
// class FileRepositoryImpl implements FileRepository {
//   final MockFileLocalDataSource dataSource;
//   FileRepositoryImpl(this.dataSource);

//   @override
//   Future<List<FileEntity>> getFiles(String storageId) async {
//     final data = await dataSource.getMockData();
//     final filesData = (data['files'] as Map)[storageId] as List;

//     return filesData
//         .map(
//           (f) => FileEntity(
//             id: '${storageId}_${f['name']}',
//             name: f['name'],
//             type: f['type'],
//             sizeInBytes: f['size'],
//             dateModified: DateTime.now().subtract(
//               Duration(days: Random().nextInt(30)),
//             ),
//           ),
//         )
//         .toList();
//   }
// }

// /// StorageRepository의 실제 구현체
// class StorageRepositoryImpl implements StorageRepository {
//   final MockFileLocalDataSource dataSource;
//   StorageRepositoryImpl(this.dataSource);

//   @override
//   Future<List<StorageDevice>> getStorageDevices() async {
//     final data = await dataSource.getMockData();
//     final storagesData = data['storages'] as List;

//     return storagesData
//         .map(
//           (s) => StorageDevice(
//             id: s['id'],
//             name: s['name'],
//             icon: s['icon'],
//             totalSpaceGB: s['total'],
//             usedSpaceGB: s['used'],
//           ),
//         )
//         .toList();
//   }

//   @override
//   Future<StorageUsage> getStorageUsage(String storageId) async {
//     final files = await FileRepositoryImpl(dataSource).getFiles(storageId);
//     double images = 0, videos = 0, music = 0, docs = 0, others = 0;

//     for (var file in files) {
//       double sizeGB = file.sizeInBytes / (1024 * 1024 * 1024);
//       switch (file.type) {
//         case FileType.image:
//           images += sizeGB;
//           break;
//         case FileType.video:
//           videos += sizeGB;
//           break;
//         case FileType.music:
//           music += sizeGB;
//           break;
//         case FileType.document:
//           docs += sizeGB;
//           break;
//         default:
//           others += sizeGB;
//           break;
//       }
//     }
//     return StorageUsage(
//       imagesSizeGB: images,
//       videosSizeGB: videos,
//       musicSizeGB: music,
//       documentsSizeGB: docs,
//       othersSizeGB: others,
//     );
//   }
// }

// // =================================================================
// // PRESENTATION LAYER - UI 및 상태 관리
// // =================================================================

// // --- Providers (Riverpod) ---

// /// 의존성 주입(DI)을 위한 Provider들
// final mockDataSourceProvider = Provider((ref) => MockFileLocalDataSource());

// final fileRepositoryProvider = Provider<FileRepository>((ref) {
//   return FileRepositoryImpl(ref.watch(mockDataSourceProvider));
// });

// final storageRepositoryProvider = Provider<StorageRepository>((ref) {
//   return StorageRepositoryImpl(ref.watch(mockDataSourceProvider));
// });

// final getStorageDevicesUseCaseProvider = Provider((ref) {
//   return GetStorageDevicesUseCase(ref.watch(storageRepositoryProvider));
// });

// final getFilesUseCaseProvider = Provider((ref) {
//   return GetFilesUseCase(ref.watch(fileRepositoryProvider));
// });

// final getStorageUsageUseCaseProvider = Provider((ref) {
//   return GetStorageUsageUseCase(ref.watch(storageRepositoryProvider));
// });

// /// UI 상태를 위한 Provider들
// final storageDevicesProvider = FutureProvider<List<StorageDevice>>((ref) {
//   return ref.watch(getStorageDevicesUseCaseProvider).call();
// });

// final selectedStorageIdProvider = StateProvider<String?>((ref) => null);

// final fileListProvider = FutureProvider.family<List<FileEntity>, String>((
//   ref,
//   storageId,
// ) {
//   return ref.watch(getFilesUseCaseProvider).call(storageId);
// });

// final storageUsageProvider = FutureProvider.family<StorageUsage, String>((
//   ref,
//   storageId,
// ) {
//   return ref.watch(getStorageUsageUseCaseProvider).call(storageId);
// });

// // --- Screens ---

// /// 파일 매니저 메인 화면
// class FileManagerScreen extends ConsumerWidget {
//   const FileManagerScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('파일 매니저'),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Row(
//         children: [
//           // 왼쪽 스토리지 목록 패널
//           Container(
//             width: 250,
//             color: const Color(0xFFE8ECF1),
//             child: const StorageListView(),
//           ),
//           // 오른쪽 파일 탐색기 패널
//           const Expanded(child: FileExplorerView()),
//         ],
//       ),
//     );
//   }
// }

// // --- Widgets ---

// /// 왼쪽 스토리지 목록 위젯
// class StorageListView extends ConsumerWidget {
//   const StorageListView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final storageDevicesAsync = ref.watch(storageDevicesProvider);
//     final selectedId = ref.watch(selectedStorageIdProvider);

//     return storageDevicesAsync.when(
//       data: (devices) {
//         // 앱 시작 시 첫 번째 스토리지를 자동으로 선택
//         if (selectedId == null && devices.isNotEmpty) {
//           Future.microtask(
//             () =>
//                 ref.read(selectedStorageIdProvider.notifier).state =
//                     devices.first.id,
//           );
//         }

//         return ListView.builder(
//           itemCount: devices.length,
//           itemBuilder: (context, index) {
//             final device = devices[index];
//             final isSelected = device.id == selectedId;
//             return Material(
//               color:
//                   isSelected
//                       ? Colors.blue.withOpacity(0.1)
//                       : Colors.transparent,
//               child: ListTile(
//                 leading: Icon(
//                   device.icon,
//                   color: isSelected ? Colors.blue : Colors.grey[700],
//                 ),
//                 title: Text(
//                   device.name,
//                   style: TextStyle(
//                     fontWeight:
//                         isSelected ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//                 subtitle: Text(
//                   '${device.usedSpaceGB.toStringAsFixed(1)}GB / ${device.totalSpaceGB.toStringAsFixed(0)}GB',
//                 ),
//                 onTap: () {
//                   ref.read(selectedStorageIdProvider.notifier).state =
//                       device.id;
//                 },
//               ),
//             );
//           },
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('오류 발생: $err')),
//     );
//   }
// }

// /// 오른쪽 파일 탐색기 위젯
// class FileExplorerView extends ConsumerWidget {
//   const FileExplorerView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedId = ref.watch(selectedStorageIdProvider);

//     if (selectedId == null) {
//       return const Center(child: Text('스토리지를 선택하세요.'));
//     }

//     final storageDevice = ref
//         .watch(storageDevicesProvider)
//         .asData
//         ?.value
//         .firstWhere((d) => d.id == selectedId);
//     final storageUsageAsync = ref.watch(storageUsageProvider(selectedId));
//     final filesAsync = ref.watch(fileListProvider(selectedId));

//     if (storageDevice == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             storageDevice.name,
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(height: 16),
//           storageUsageAsync.when(
//             data:
//                 (usage) => StorageUsageBar(usage: usage, device: storageDevice),
//             loading:
//                 () => const SizedBox(
//                   height: 80,
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//             error: (e, s) => Text('사용량 정보를 가져오지 못했습니다: $e'),
//           ),
//           const SizedBox(height: 24),
//           Text('파일 목록', style: Theme.of(context).textTheme.titleMedium),
//           const Divider(height: 24),
//           Expanded(
//             child: filesAsync.when(
//               data:
//                   (files) => ListView.builder(
//                     itemCount: files.length,
//                     itemBuilder:
//                         (context, index) => FileListItem(file: files[index]),
//                   ),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (e, s) => Text('파일 목록을 가져오지 못했습니다: $e'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// 스토리지 사용량 프로그레스 바 위젯
// class StorageUsageBar extends StatelessWidget {
//   final StorageUsage usage;
//   final StorageDevice device;

//   const StorageUsageBar({super.key, required this.usage, required this.device});

//   @override
//   Widget build(BuildContext context) {
//     final totalUsed = device.usedSpaceGB;
//     final totalSpace = device.totalSpaceGB;

//     final Map<String, double> usageMap = {
//       '이미지': usage.imagesSizeGB,
//       '동영상': usage.videosSizeGB,
//       '음악': usage.musicSizeGB,
//       '문서': usage.documentsSizeGB,
//       '기타': usage.othersSizeGB,
//     };

//     final Map<String, Color> colorMap = {
//       '이미지': Colors.blue,
//       '동영상': Colors.red,
//       '음악': Colors.purple,
//       '문서': Colors.green,
//       '기타': Colors.orange,
//     };

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   '저장 공간',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '${totalUsed.toStringAsFixed(1)}GB / ${totalSpace.toStringAsFixed(0)}GB 사용됨',
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: SizedBox(
//                 height: 12,
//                 child: Row(
//                   children:
//                       usageMap.entries.map((entry) {
//                         final proportion =
//                             totalUsed > 0 ? entry.value / totalUsed : 0;
//                         return Expanded(
//                           flex: (proportion * 100).toInt(),
//                           child: Container(color: colorMap[entry.key]),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 16,
//               runSpacing: 8,
//               children:
//                   usageMap.entries.map((entry) {
//                     return Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width: 10,
//                           height: 10,
//                           color: colorMap[entry.key],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${entry.key} (${entry.value.toStringAsFixed(2)}GB)',
//                         ),
//                       ],
//                     );
//                   }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// 파일 목록의 각 아이템 위젯
// class FileListItem extends StatelessWidget {
//   final FileEntity file;
//   const FileListItem({super.key, required this.file});

//   IconData _getIconForType(FileType type) {
//     switch (type) {
//       case FileType.folder:
//         return Icons.folder;
//       case FileType.image:
//         return Icons.image;
//       case FileType.video:
//         return Icons.movie;
//       case FileType.music:
//         return Icons.music_note;
//       case FileType.document:
//         return Icons.description;
//       default:
//         return Icons.insert_drive_file;
//     }
//   }

//   String _formatBytes(int bytes) {
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(
//         _getIconForType(file.type),
//         color:
//             file.type == FileType.folder ? Colors.amber[700] : Colors.grey[600],
//       ),
//       title: Text(file.name),
//       subtitle: Text(
//         file.type == FileType.folder ? '' : _formatBytes(file.sizeInBytes),
//       ),
//       trailing: Text(
//         '${file.dateModified.year}-${file.dateModified.month}-${file.dateModified.day}',
//       ),
//     );
//   }
// }
