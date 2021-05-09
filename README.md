# pecker_flutter


## 历史痛点

目前线上产品的架构是通过 `mobx`, `sqflite`, `dio` 等几个基础插件，根据老项目具体需求搭建而成。
期初项目比较简单，表现还是不错的。
不过随着项目越来越复杂，架构就暴露出不小问题

1. 由于没有严格的目录与命名规范，方法命名，目录结构很随意。
2. 项目初始化方法里有大量的实现代码，让整个 `setup` 很臃肿。
3. `mobx` 作为状态管理，每次 `run build` 的时候都非常费时。
4. 做界面统计的时候需要在每个界面注入代码。
5. 没有统一的路由声明周期管理，界面是否打开全局难以把控
6. 代码偶尔太强，很难编写测试代码。
7. 捕获到的错误日志有限，就算捕获到也难以界定哪里出了问题，因为错误信息往往是原生端的。
8. 国家化使用的 `i18n_extension`, 使用起来是方便，不过在整理多语言的配置文件的时候还是不够规范
9. 没有任务管理器，并发任务无法统一调度。
10. 管理数据库表模型需要大量代码，升级也容易犯错。

以上是比较突出的问题，还有形形色色的小问题，迫使我必须开始搭建适应现在项目需求的架构了。


## 目标

这个架构旨在解决以上所有痛点，不过万丈高楼平地起，先在这里定下目标逐个攻破。

[x] 确定项目结构，功能划分明确
[] 确定命名规范
[x] 确定 `setup` 流程与内部代码规范
[x] 使用 `get` 替代 `mobx`
[x] 全局路由可以把控各页面的打开关闭，全局可以获得每个开启页面的状态
[] 在全局页面合理的安排统计代码。
[x] 完全结构 `ui` 和 `controller`。
[] 测试代码通过重写 `Service` 进行 mock
[] 基于新框架编写单元测试和ui测试范本
[x] 规范化国际化代码
[x] `sentry` 捕获错误，进行合理的错误埋点
[x] 统一的任务管理服务，并发任务线型执行。
[x] 引入新的`moor` 替代 `sqflite`，让建库更直观， 升级更容易


## 项目结构

```bash
.
├── app
│   ├── data
│   │   ├── apis                             # 网络请求接口
│   │   ├── databases                        # 数据库相关 
│   │   │   ├── app_db.dart          
│   │   │   ├── app_db.g.dart
│   │   │   ├── daos
│   │   │   └── tables
│   │   └── services
│   │       ├── app_service.dart              # 应用相关通用初始化内容
│   │       ├── connectivity_service.dart     # 网络连接状态监控服务
│   │       ├── db_service.dart               # 数据库服务
│   │       ├── lifecycle_service.dart        # 应用生命周期监控服务
│   │       ├── preferences_service.dart      # 本地存储服务 
│   │       ├── task_service.dart             # 任务调度服务
│   │       └── vibration_service.dart        # 震动服务
│   ├── global_widgets                        # 全局会使用的公用组件
│   ├── locales                               
│   │   └── app_locales.dart                  # 应用所选语言
│   ├── modules                               # page 目录 
│   │   └── home                              # 主页 这个结构通过工具自动创建
│   │       ├── bindings                            
│   │       ├── controllers
│   │       └── views
│   ├── routes                                 # 路由相关
│   │   ├── app_middlewares.dart               # 全局路由监控，这里面记录当前路由状态
│   │   ├── app_pages.dart                     # 页面信息, 通过工具自动添加页面
│   │   ├── app_routes.dart                    # 路由信息，通过工具自动添加路由
│   │   └── middlewares                        # 中间件存放目录
│   └── themes
│       ├── app_theme.dart                     # 应用主题定义
│       ├── dark.dart                          # 黑色主题
│       └── light.dart                         # 亮色主题
├── config.dart                                # 全局常量配置
├── generated
│   └── locales.g.dart                         # 通过工具生成的国际化代码
├── main.dart                                  # 应用入口
└── utils
    ├── index.dart
    ├── log.dart                                # 日志
    ├── my_tools.dart                           # 工具类
    ├── my_ui.dart                              # ui 工具  
    └── screen.dart                             # 自适应工具
```

## 准备工作

安装 [get_cli](https://github.com/jonataslaw/get_cli),这样可以通过命令行创建界面和生成国际化代码，解放生产力。
安装 [VSCode 插件](https://marketplace.visualstudio.com/items?itemName=get-snippets.get-snippets) 或者 [Android Studio/Intellij 插件](https://plugins.jetbrains.com/plugin/14975-getx-snippets)，它可以帮助在开发中提高开发效率，我用的最多的就是 `getfinal_`，不要问为什么，用了就知道。


## 如何使用

### setup 规范 是什么？

1. 不出现业务代码
2. 只包含 Service 类
3. 多 Service 如果有依赖关系，需要严格使用 `await` 控制。

```dart
Future initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskService()..init());
  await Get.putAsync(() => ConnectivityService().init());

  await Get.putAsync(() => SharedPreferecesService().init());
  Get.put(DbService());
  await Get.putAsync(() => AppService().init());

  await Get.putAsync(() => VibrationService().init());
}
```

### 怎么创建新界面

在项目根目录，命令行执行

```bash
$ get create page:your_page
```
以上命令会自动在 modules 目录里创建 your_page 目录和代码结构，同时会在 routes 目录创建路由

想要跳转到新创建的界面只需要指定 `Get.toNamed(Routes.YOUR_PAGE)` 就可以了

### 怎么使用 dialog 或者 bottomSheet 包装 Page

```dart
// 使用 dialog 打开
MyUI.showPageDailog(
  routeName: Routes.LOGIN,
  titleText: '登录注册',
  onDispose: loginBindingDispose,
)

// 使用 bottomSheet 打开
MyUI.showPageBottomSheet(
  routeName: Routes.LOGIN,
  onDispose: loginBindingDispose,
);

// 由于 Dialog 和 BottomSheet 关闭不会触发 bindings 的释放，所以需要手动释放 controller
loginBindingDispose() {
  Get.delete<LoginController>();
}

```

### 怎么让拼任务顺序执行

```dart
// 下面 3 个弹出框会依次打开
TaskService.to.doTask(() => MyUI.showDialog());
TaskService.to.doTask(() => MyUI.showDialog());
TaskService.to.doTask(() => MyUI.showDialog());

// MyUI 库里提供了几个方法通过 TaskService 包装的
MyUI.showSyncDefaultDialog();
MyUI.showSyncDialog();
```

### 怎么实现国际化

在 `assets/locales` 目录里创建 `en_US.json`

```json
{
  "app": {
    "name": "Pecker Flutter"
  },
  "locales": {
    "zh": "Chinese",
    "en": "English"
  }
}
```

执行

```bash
$ get generate locales assets/locales
```

```dart
Text(
  LocaleKeys.app_name.tr
)
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

### 怎么监听应用的生命周期

```dart
  late Worker _lifecycleWorker;

  @override
  void onInit() {
    _lifecycleWorker =
        ever<AppLifecycleState>(LifecycleService.to.rxStatus, (status) {
      if (status == AppLifecycleState.resumed) {
        TaskService.to.doTask(() => checkBattleCustomRoom());
      }
    });
    super.onInit();
  }


  @override
  void onClose() {
    _lifecycleWorker.dispose();
    super.onClose();
  }

```

### 怎么监听应用网络状态

```dart
  late Worker _connectivityWorker;


  _connectivityWorker =
      ever<ConnectivityResult>(ConnectivityService.to.rsStatus, (status) {
    if (status == ConnectivityResult.none) {
      close();
    } else {
      connect();
    }
  });


  ...

  _connectivityWorker.dispose()
```