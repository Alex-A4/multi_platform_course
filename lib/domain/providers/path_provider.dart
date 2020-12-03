import 'package:path/path.dart';

/// Класс, который позволяет получить пути к некоторым каталогам
abstract class PathProvider {
  Future<String> get rootPath;

  Future<String> concatWithRoot(String path) async {
    final root = await rootPath;
    return join(root, path);
  }
}
