import 'package:flutter/material.dart';

import 'package:bubble_box/bubble_box.dart';
import 'package:supercharged_dart/supercharged_dart.dart';

/// 和 Toast.showAttachedWidget 配合，显示有箭头的容器，箭头指向 [targetCenterOffset] 位置。根据 [child] 布局自动撑开容器
///
/// ```
/// BotToast.showAttachedWidget(
///   attachedBuilder: (closeBubble) => MyBubbleBox(
///     targetCenterOffset: targetCenter,
///     backgroundColor: backgroundColor,
///     child: Text('BubbleBox'),
///   ),
///   targetContext: context,
/// );
/// ```
class MyBubbleBox extends StatefulWidget {
  MyBubbleBox({
    required this.targetCenterOffset,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderSize,
    this.isDashedBorder = false,
  });

  final Offset targetCenterOffset;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderSize;
  final bool isDashedBorder;

  @override
  _MyBubbleBoxState createState() => _MyBubbleBoxState();
}

class _MyBubbleBoxState extends State<MyBubbleBox> {
  final GlobalKey boxKey = GlobalKey();
  BubblePosition? bubblePostion;
  BubbleDirection bubbleDirection = BubbleDirection.none;
  bool isShow = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!mounted) {
        return;
      }
      if (bubblePostion == null) {
        final box = context.findRenderObject() as RenderBox;
        final bubbleOffset = box.localToGlobal(Offset.zero);
        // 根据目标节点的中心位置来调整箭头指向和位置
        setState(() {
          bubblePostion = BubblePosition(
              left: widget.targetCenterOffset.dx - bubbleOffset.dx - 7);
          bubbleDirection = bubbleOffset.dy > widget.targetCenterOffset.dy
              ? BubbleDirection.top
              : BubbleDirection.bottom;
        });
        // 更新箭头位置和指向后需要时间来刷新布局，延时0.2秒再显示内容，要不会闪烁
        0.2.seconds.delay.then((value) => mounted
            ? setState(() {
                isShow = true;
              })
            : null);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isShow ? 1 : 0,
      child: BubbleBox(
        key: boxKey,
        maxWidth: MediaQuery.of(context).size.width * 0.85,
        elevation: 5,
        backgroundColor: isShow
            ? widget.backgroundColor ?? Color.fromARGB(180, 0, 0, 0)
            : null,
        borderRadius: BorderRadius.circular(8),
        direction: bubbleDirection,
        position: bubblePostion,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        border: widget.borderColor != null
            ? BubbleBoxBorder(
                color: widget.borderColor!,
                width: widget.borderSize ?? 1,
                style: widget.isDashedBorder
                    ? BubbleBoxBorderStyle.dashed
                    : BubbleBoxBorderStyle.solid,
              )
            : null,
        shadowColor: Colors.black38,
        child: widget.child,
      ),
    );
  }
}
