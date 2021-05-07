import 'package:flutter/material.dart';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:get/get.dart';

import '../../utils/screen.dart';
import 'controllers/my_pageview_controller.dart';
import 'controllers/my_tab_bar_controller.dart';

const double _kTabHeight = 46.0;

class MyTabBar extends StatefulWidget implements PreferredSizeWidget {
  MyTabBar({
    Key? key,
    required this.tabs,
    this.isScrollable = false,
    this.tag,
    this.pageViewTag,
    this.onTap,
  }) : super(key: key);

  final List<String> tabs;
  final bool isScrollable;
  final String? tag;
  final String? pageViewTag;
  final Function(int)? onTap;

  @override
  Size get preferredSize {
    return Size.fromHeight(_kTabHeight + 8.w);
  }

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTabBarController>(
      tag: widget.tag,
      init: MyTabBarController(tabs: widget.tabs, vsync: this),
      didUpdateWidget: (controller, state) {
        state.setState(() {
          Get.find<MyTabBarController>(tag: widget.tag).controller =
              TabController(length: widget.tabs.length, vsync: this);
        });
      },
      builder: (controller) => Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: TabBar(
            labelStyle: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w700),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            unselectedLabelColor: Theme.of(context).disabledColor,
            isScrollable: widget.isScrollable,
            controller: controller.controller,
            indicator: BubbleTabIndicator(
                indicatorColor: Theme.of(context).primaryColor,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorRadius: 100,
                insets:
                    EdgeInsets.symmetric(vertical: -15.w, horizontal: -40.w)),
            tabs: widget.tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            onTap: widget.onTap == null && widget.pageViewTag == null
                ? null
                : (index) {
                    widget.onTap?.call(index);
                    if (widget.pageViewTag != null)
                      Get.find<MyPageViewController>(tag: widget.pageViewTag)
                          .controller
                          .jumpToPage(index);
                  }),
      ),
    );
  }
}
