import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/index.dart';
import '../../../global_widgets/index.dart';
import '../controllers/global_widgets_sample_controller.dart';

class GlobalWidgetsSampleView extends GetView<GlobalWidgetsSampleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global widgets example'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: ScreenUtil.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              AnimButton(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  width: 200,
                  height: 50,
                  child: Text(
                    'AnimButton',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MyButton(
                key: controller.bubbleBoxBtnKey,
                onTap: () {
                  controller.showBubbleBox();
                },
                width: 200,
                height: 50,
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                text: 'MyBubbleBox',
                fontColor: Colors.white,
              ),
              SizedBox(height: 10),
              MyButton(
                onTap: () {
                  controller.showMyDialog();
                },
                width: 200,
                height: 50,
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                text: 'MyDialog',
                fontColor: Colors.white,
              ),
              SizedBox(height: 10),
              MyButton(
                onTap: () {
                  controller.showPopAnimDialog();
                },
                width: 200,
                height: 50,
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                text: 'PopAnimBox',
                fontColor: Colors.white,
              ),
              SizedBox(height: 20),
              MySearchBar(
                width: ScreenUtil.screenWidth - 20,
                height: 40,
                fontSize: 16,
              ),
              SizedBox(height: 20),
              Container(
                width: ScreenUtil.screenWidth - 20,
                height: ScreenUtil.screenWidth / 2,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(),
                  ],
                ),
                child: Column(
                  children: [
                    MyTabBar(
                      tabs: ['Tab1', 'Tab2', 'Tab3'],
                      tag: 'tabbar_tag',
                      pageViewTag: 'pageview_tag',
                    ),
                    Divider(
                      color: Theme.of(context).disabledColor,
                    ),
                    Expanded(
                      child: MyPageView(
                        tag: 'pageview_tag',
                        tabBarTag: 'tabbar_tag',
                        pages: [
                          KeepAliveWrapper(
                              child: Center(
                            child: Text('Page1'),
                          )),
                          KeepAliveWrapper(
                              child: Center(
                            child: Text('Page2'),
                          )),
                          KeepAliveWrapper(
                              child: Center(
                            child: Text('Page3'),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  TipsButton(
                    onTap: () {},
                    isLeft: true,
                    title: 'left tips',
                    backgroundColor: Colors.primaries[0],
                    animateIn: true,
                  ),
                  Spacer(),
                  TipsButton(
                    onTap: () {},
                    isLeft: false,
                    title: 'right tips',
                    backgroundColor: Colors.primaries[1],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
