import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/index.dart';
import '../../../global_widgets/index.dart';
import '../../../global_widgets/my_button.dart';
import '../../../routes/index.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print(Get.isDarkMode);
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MyButton(
                width: 900.w,
                height: 120.w,
                text: 'Global widgets example',
                onTap: () {
                  Get.toNamed(Routes.GLOBAL_WIDGETS_SAMPLE);
                },
              ),
              SizedBox(height: 20.w),
              MyButton(
                width: 900.w,
                height: 120.w,
                text: 'Locales examples',
                onTap: () {
                  Get.toNamed(Routes.LOCALES_SAMPLE);
                },
              ),
              SizedBox(height: 20.w),
              MyButton(
                width: 900.w,
                height: 120.w,
                text: 'Change theme',
                onTap: controller.changeTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
