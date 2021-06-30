import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/students.dart';
import 'tables/students.dart';

part 'app_db.g.dart';

@UseMoor(
  // 绑定 tables
  tables: [Students],
  // 绑定 daos
  daos: [StudentsDao],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 数据库版本升级处理代码在这里进行
  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {});
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    /// 定义数据库存储路劲
    final file = File(p.join(
        (await getApplicationDocumentsDirectory()).path, 'app_db.sqlite'));
    return VmDatabase(file);
  });
}
