# pecker_flutter
## 历史痛点
<details>
<summary>展开详情</summary>

目前线上产品的架构是通过 `mobx`, `sqflite`, `dio` 等几个基础插件，根据老项目具体需求搭建而成。
期初项目比较简单，表现还是不错的。
不过随着项目越来越复杂，架构就暴露出不小问题

1. 由于没有严格的目录与命名规范，方法命名，目录结构很随意。
2. 项目初始化方法里有大量的实现代码，让整个 `setup` 很臃肿。
3. `mobx` 作为状态管理，每次 `run build` 的时候都非常费时。
4. 做界面统计的时候需要在每个界面注入代码。
5. 没有统一的路由声明周期管理，界面是否打开全局难以把控
6. 代码耦合太强，很难编写测试代码。
7. 捕获到的错误日志有限，就算捕获到也难以界定哪里出了问题，因为错误信息往往是原生端的。
8. 国家化使用的 `i18n_extension`, 使用起来是方便，不过在整理多语言的配置文件的时候还是不够规范
9. 没有任务管理器，并发任务无法统一调度。
10. 管理数据库表模型需要大量代码，升级也容易犯错。

以上是比较突出的问题，还有形形色色的小问题，迫使我必须开始搭建适应现在项目需求的架构了。
</details>

## 目标
<details>
<summary>展开详情</summary>

这个架构旨在解决以上所有痛点，不过万丈高楼平地起，先在这里定下目标逐个攻破。

- [x] 确定项目结构，功能划分明确
- [ ] 确定命名规范
- [x] 确定 `setup` 流程与内部代码规范
- [x] 使用 `get` 替代 `mobx`
- [x] 全局路由可以把控各页面的打开关闭，全局可以获得每个开启页面的状态
- [ ] 在全局页面合理的安排统计代码。
- [x] 完全结构 `ui` 和 `controller`。
- [ ] 测试代码通过重写 `Service` 进行 mock
- [ ] 基于新框架编写单元测试和ui测试范本
- [x] 规范化国际化代码
- [x] `sentry` 捕获错误，进行合理的错误埋点
- [x] 统一的任务管理服务，并发任务线型执行。
- [x] 引入新的`moor` 替代 `sqflite`，让建库更直观， 升级更容易
</details>

## 项目结构
<details>
<summary>展开详情</summary>

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
</details>

## 准备工作

### 第三方插件文档

- [getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md)
- [moor](https://moor.simonbinder.eu/docs/)
### 工具安装

- 安装 [get_cli](https://github.com/jonataslaw/get_cli)，这样可以通过命令行创建界面和生成国际化代码，解放生产力。
- 安装 [VSCode 插件](https://marketplace.visualstudio.com/items?itemName=get-snippets.get-snippets) 或者 [Android Studio/Intellij 插件](https://plugins.jetbrains.com/plugin/14975-getx-snippets)，它可以帮助在开发中提高开发效率，我用的最多的就是 `getfinal_`，不要问为什么，用了就知道。


## 如何使用

### 全局配置

`app/config.dart` 进行全局应用必要参数配置

```dart
class Config {
  /// 应用名
  static const APP_NAME = 'Pecker Flutter';
  /// 日志登记
  static const LOG_LEVEL = Level.debug;
  /// 是否输出 getx 日志
  static const GETX_DEBUG = true;
  // TODO 你的 Sentry Dsn
  static const SENTRY_DSN = 'your SENTRY_DSN';
  // TODO http 请求 host
  static const API_HOST = kReleaseMode
      ? 'API_HOST'
      : 'API_HOST_TEST';
  // TODO ws 请求 host
  static const WS_HOST = kReleaseMode
      ? 'WS_HOST'
      : 'WS_HOST_TEST';
}
```

### 服务模块

[传送门](docs/services/index.md)

### 全局通用组件

[传送门](docs/global_widgets/index.md)

### 工具模块

[传送门](docs/utils/index.md)
### 路由模块

[传送门](docs/route.md)

### 国际化

[传送门](docs/locales.md)

### 暗黑和亮色主题

[传送门](docs/theme.md)

### 代码规范

[代码规范](docs/code_standards.md)


## 注意事项

1. `GetController` 不被引用的时候会自动释放，如果想让某个 `Controller` 常驻, 需使用 `permanent` 字段.

```dart
`Get.put(StageListController(), permanent: true);
```

2. `GetController` 的 `onInit` 方法里不要调用 `Get.back` 等方法退出页面，否则 `onClose` 不会被触发

3. `ValueBuilder` 配合 `SharedPreferecesService` 可以包装快捷开关配置


```dart
// 音效是否开启
bool get audioSwitch => _prefs.getBool('switchSound') ?? true;
setAudioSwitch(value) => _prefs.setBool("switchSound", value);
```

```dart
buildSwitchBlock(
    context: context,
    title: '音效',
    initValue: S().audioSwitch,
    setter: S().setAudioSwitch,
),


Widget buildSwitchBlock({
    required context,
    required String title,
    String? subTitle,
    String? subTitleOff,
    required bool initValue,
    required Function(bool) setter,
    Function? onChanged,
  }) {
    if (subTitleOff != null) {
      return ValueBuilder<bool?>(
        initialValue: initValue,
        builder: (value, updateFunc) => ListTile(
          title: Text(title),
          subtitle: value == true
              ? (subTitle != null ? Text(subTitle) : null)
              : Text(subTitleOff),
          trailing: SizedBox(
            height: 100.w,
            width: 200.w,
            child: CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor,
              value: value ?? false,
              onChanged: updateFunc,
            ),
          ),
        ),
        onUpdate: (value) {
          setter(value ?? false);
          onChanged?.call();
        },
      );
    }

    return DefaultTextStyle(
        style: TextStyle(),
        child: ListTile(
          title: Text(title),
          subtitle: subTitle != null ? Text(subTitle) : null,
          trailing: SizedBox(
            height: 100.w,
            width: 200.w,
            child: ValueBuilder<bool?>(
              initialValue: initValue,
              builder: (value, updateFunc) => CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: value ?? false,
                onChanged: updateFunc,
              ),
              onUpdate: (value) {
                setter(value ?? false);
                onChanged?.call();
              },
            ),
          ),
        ));
}
```


