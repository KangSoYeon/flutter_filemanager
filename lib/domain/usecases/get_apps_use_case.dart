import '../entities/app_entity.dart';
import '../repositories/app_repository.dart';

class GetAppsUseCase {
  final AppRepository repository;
  GetAppsUseCase(this.repository);

  Future<List<AppEntity>> call() {
    return repository.getInstalledApps();
  }
}
