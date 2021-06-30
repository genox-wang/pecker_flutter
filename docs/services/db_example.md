# 数据库服务使用流程

> Moor 高级使用方法请参考 [官方文档](https://moor.simonbinder.eu/docs/)

### 创建表

在 `databases/tables` 里创建表文件

```dart
import 'package:moor/moor.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get score => integer()();
}
```

### 创建 Dao

在 `databases/daos` 里创建表对应的 dao 文件

```dart
import 'package:moor/moor.dart';

import '../app_db.dart';
import '../tables/students.dart';

part 'students.g.dart';

@UseDao(tables: [Students])
class StudentsDao extends DatabaseAccessor<AppDb> with _$StudentsDaoMixin {
  StudentsDao(AppDb db) : super(db);
}
```

### 绑定表和 Dao 到 DB

`databases/app_db.dart`

```dart
@UseMoor(
  // 绑定 tables
  tables: [Students],
  // 绑定 daos
  daos: [StudentsDao],
)
class AppDb extends _$AppDb {
```

### 生成代码

```shell
flutter pub run build_runner build 
```

### 在 Dao 文件中编写表操作逻辑

```dart
import 'package:moor/moor.dart';

import '../app_db.dart';
import '../tables/students.dart';

part 'students.g.dart';

@UseDao(tables: [Students])
class StudentsDao extends DatabaseAccessor<AppDb> with _$StudentsDaoMixin {
  StudentsDao(AppDb db) : super(db);

  Future<List<Student>> getAll() {
    return select(students).get();
  }

  Future<int> addOne({
    required String name,
    required int score,
  }) {
    return into(students)
        .insert(StudentsCompanion.insert(name: name, score: score));
  }

  Future<int> removeOne(int id) {
    return (delete(students)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future updateOne(Student student) {
    return (update(students)..where((tbl) => tbl.id.equals(student.id)))
        .write(student);
  }
}
```


### 在项目中操作表

```dart
StudentsDao dao = DbService.to.db.studentsDao;

dao.getAll();

dao.updateOne(data);
    
dao.addOne('Wang', 10);

dao.removeOne(1);
```