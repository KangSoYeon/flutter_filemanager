import '../datasources/mock_app_data_source.dart';
import '../../domain/entities/app_entity.dart';
import '../../domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final MockAppDataSource dataSource;
  AppRepositoryImpl(this.dataSource);

  @override
  Future<List<AppEntity>> getInstalledApps() async {
    final mockApps = await dataSource.getMockApps();
    return mockApps
        .map(
          (app) => AppEntity(
            id: app['name'],
            icon: app['icon'],
            name: app['name'],
            sizeInMB: app['size'],
            version: app['version'],
          ),
        )
        .toList();
  }
}
