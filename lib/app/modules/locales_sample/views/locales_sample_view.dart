import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../utils/index.dart';
import '../../../global_widgets/index.dart';
import '../controllers/locales_sample_controller.dart';

class LocalesSampleView extends GetView<LocalesSampleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocalesSampleView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.w,
          ),
          Obx(
            () => MyButton(
              onTap: controller.onLocaleClicked,
              width: 900.w,
              height: 120.w,
              radius: 20.w,
              text: controller.languageCode.isEmpty
                  ? LocaleKeys.locales_system.tr
                  : controller.languageCode == 'zh'
                      ? LocaleKeys.locales_zh.tr
                      : LocaleKeys.locales_en.tr,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(LocaleKeys.aphorism_1.tr),
                Text(LocaleKeys.aphorism_2.tr),
                Text(LocaleKeys.aphorism_3.tr),
                Text(LocaleKeys.aphorism_4.tr),
                Text(LocaleKeys.aphorism_5.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
