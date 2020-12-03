import 'package:multi_platform_course/domain/providers/path_provider.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderImpl extends PathProvider {
  @override
  Future<String> get rootPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
