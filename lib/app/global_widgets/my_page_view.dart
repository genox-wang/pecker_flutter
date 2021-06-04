import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'controllers/my_pageview_controller.dart';
import 'controllers/my_tab_bar_controller.dart';

/// 配合 [MyTabBar] 使用
///
/// 实现 PageView 和 TabBar 的双向绑定
///
/// ```
/// MyTabBar(
///   tabs: tabs,
///   tag: 'tabbar_tag',
///   pageViewTag: 'pageview_tag',
/// ),
/// MyPageView(
///   tag: 'pageview_tag',
///   tabBarTag: 'tabbar_tag'
/// )
/// ```
///
class MyPageView extends StatelessWidget {
  MyPageView({
    required this.pages,
    this.tabBarTag,
    this.tag,
    this.physics,
  });

  final List<Widget> pages;
  final String? tag;
  final String? tabBarTag;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPageViewController>(
      tag: tag,
      init: MyPageViewController(),
      builder: (controller) => PageView(
        physics: physics,
        controller: controller.controller,
        children: pages,
        onPageChanged: tabBarTag == null
            ? null
            : (index) => Get.find<MyTabBarController>(tag: tabBarTag)
                .controller
                .animateTo(index),
      ),
    );
  }
}
