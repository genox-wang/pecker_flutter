### 国际化

#### 生成国际化文件

##### 1. 在 `assets/locales` 文件夹下创建对应语言的国家化文本

en.json

```json
{
  "app": {
    "name": "Pecker Flutter",
    "cancel": "Cancel"
  },
  "aphorism": {
    "1": "The roots of education are bitter , but the fruit is sweet .",
    "2": "Patience is bitter, but its fruit is sweet .",
    "3": "To sensible men, every day is a day of reckoning.",
    "4": "I have nothing to offer but blood , toil tears and sweat .",
    "5": "Never leave that until tomorrow , which you can do today ."
  },
  "locales": {
    "zh": "Chinese",
    "en": "English",
    "system": "System"
  }
}
```

zh.json

```json
{
  "app": {
    "name": "Pecker Flutter",
    "cancel": "取消"
  },
  "aphorism": {
    "1": "教育的根是苦的，但其果实是甜的。",
    "2": "忍耐是痛苦的，但它的果实是甜蜜的。",
    "3": "对聪明人来说，每一天的时间都是要精打细算的。",
    "4": "我所能奉献的没有其它，只有热血、辛劳、眼泪与汗水。",
    "5": "今天的事不要拖到明天。"
  },
  "locales": {
    "zh": "简体中文",
    "en": "英语",
    "system": "跟随系统"
  }
}
```

##### 2. 生成代码

```shell
get generate locales assets/locales   
```

在 `generated` 目录下会生成 `locales.g.dart` 文件

```dart
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// ignore_for_file: lines_longer_than_80_chars
// ignore: avoid_classes_with_only_static_members
class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'zh': Locales.zh,
    'en': Locales.en,
  };
}

class LocaleKeys {
  LocaleKeys._();
  static const app_name = 'app_name';
  static const app_cancel = 'app_cancel';
  static const aphorism_1 = 'aphorism_1';
  static const aphorism_2 = 'aphorism_2';
  static const aphorism_3 = 'aphorism_3';
  static const aphorism_4 = 'aphorism_4';
  static const aphorism_5 = 'aphorism_5';
  static const locales_zh = 'locales_zh';
  static const locales_en = 'locales_en';
  static const locales_system = 'locales_system';
}

class Locales {
  static const zh = {
    'app_name': 'Pecker Flutter',
    'app_cancel': '取消',
    'aphorism_1': '教育的根是苦的，但其果实是甜的。',
    'aphorism_2': '忍耐是痛苦的，但它的果实是甜蜜的。',
    'aphorism_3': '对聪明人来说，每一天的时间都是要精打细算的。',
    'aphorism_4': '我所能奉献的没有其它，只有热血、辛劳、眼泪与汗水。',
    'aphorism_5': '今天的事不要拖到明天。',
    'locales_zh': '简体中文',
    'locales_en': '英语',
    'locales_system': '跟随系统',
  };
  static const en = {
    'app_name': 'Pecker Flutter',
    'app_cancel': 'Cancel',
    'aphorism_1':
        'The roots of education are bitter , but the fruit is sweet .',
    'aphorism_2': 'Patience is bitter, but its fruit is sweet .',
    'aphorism_3': 'To sensible men, every day is a day of reckoning.',
    'aphorism_4': 'I have nothing to offer but blood , toil tears and sweat .',
    'aphorism_5': 'Never leave that until tomorrow , which you can do today .',
    'locales_zh': 'Chinese',
    'locales_en': 'English',
    'locales_system': 'System',
  };
}
```

##### 3. 在项目中使用

```dart
ListView(
  padding: EdgeInsets.all(20),
  children: [
    Text(LocaleKeys.aphorism_1.tr),
    Text(LocaleKeys.aphorism_2.tr),
    Text(LocaleKeys.aphorism_3.tr),
    Text(LocaleKeys.aphorism_4.tr),
    Text(LocaleKeys.aphorism_5.tr),
  ],
)
```

##### 4. 切换语言

```dart

void updateLocale(Locale? locale) {
  // 通过 Get 切换当前语言，传入空表示跟随系统
  Get.updateLocale(locale ?? window.locale);
  // 语言切换完成状态保存到本地
  if (locale != null) {
    S().languageCode = Get.locale!.languageCode;
  } else {
    S().languageCode = '';
  }
}
```