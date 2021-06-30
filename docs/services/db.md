## DB

> 使用样例参考[《数据库服务使用流程》](db_example.md)

与 `app/data/databases` 配合使用

`DbService.to.db` 就是 `AppDb` 实例。

```dart
// 通过 gameBoardsDao 查询数据
final gameBoard = await DbService.to.db.gameBoardsDao
   .getOne(battleGameInfo.boardId);
```

### 怎么创建数据库

在 `data/databases/tables` 目录下创建表文件 `game_steps.dart`

```dart
import 'package:moor/moor.dart';

class GameSteps extends Table {
  TextColumn get gameId => text()(); // 游戏 uuid
  IntColumn get action => integer()(); // 操作 id
  IntColumn get value => integer()(); // 操作的数字
  IntColumn get index => integer()(); // 选中格子的索引
  IntColumn get duration => integer()(); // 毫秒
  IntColumn get stepId => integer()(); // 步骤序号递增
}
```

在 `data/databases/daos` 目录下创建文件 `game_steps.dart`

```dart
import 'package:moor/moor.dart';

import '../app_db.dart';
import '../tables/game_steps.dart';


part 'game_steps.g.dart';

@UseDao(tables: [GameSteps])
class GameStepsDao extends DatabaseAccessor<AppDb> with _$GameStepsDaoMixin {
  GameStepsDao(AppDb db) : super(db);
}
```

在 `data/databases/app_db.dart` 中添加 `GameSteps`和`GameStepsDao`

```dart
 tables: [
    GameSteps,
  ],
  daos: [
    GameStepsDao,
  ],
)
class AppDb extends _$AppDb { 

```

执行 

```bash
$ flutter pub run build_runner build 
```

表文件代码会自动生成，切绑定数据库，数据库代码就可以在 `GameStepsDao` 内进行编写了。


### 怎么升级数据库

数据库如果升级版本了，对应的迁移代码可以在 `AppDb.migration` 里编写。

```dart
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(userAvatars, userAvatars.expireTime);
        }
        if (from < 3) {
          await m.createTable(notifications);
        }
        if (from < 4) {
          await m.createTable(gameBoards);
          await m.createTable(gameInfos);
          await m.createTable(gameReplays);
          await m.createTable(gameSteps);
        }
      });
}

```
