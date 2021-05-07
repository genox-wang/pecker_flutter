import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SimpleButton extends StatefulWidget {
  final Function()? onTap;
  final Widget? child;
  final HitTestBehavior? behavior;
  final SimpleButtonTapTime tapTime;
  // SimpleButton 支持组配置，同组内的按键同时只能触发一个，其他都会被忽略
  final Object? group;
  final Function(dynamic)? onTapDown;
  final Function(dynamic)? onTapUp;
  final Function()? onTapCancel;
  final Duration? duration;
  final Duration? reverseDuration;
  final SimpleButtonAnimController? animController;
  final double? end;

  SimpleButton({
    key,
    this.onTap,
    this.behavior,
    this.tapTime = SimpleButtonTapTime.BeforeAnim,
    this.group,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.duration,
    this.reverseDuration,
    this.end,
    this.animController,
    @required this.child,
  }) : super(key: key);

  @override
  _SimpleButtonState createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> with AnimationMixin {
  late Animation<double> scale;

  @override
  void initState() {
    scale = 1.0
        .tweenTo(widget.end ?? 0.95)
        .curved(Curves.bounceInOut)
        .animatedBy(controller);
    // scale.curve(Curves.elasticOut);
    controller.duration = widget.duration ?? 0.1.seconds;
    // controller.curve(Curves.bounceInOut);
    controller.reverseDuration = widget.reverseDuration ?? 0.1.seconds;

    if (widget.animController != null) {
      widget.animController?.play = () => playAnim();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTapDown,
      onTapCancel: widget.onTapCancel,
      onTapUp: widget.onTapUp,
      behavior: widget.behavior,
      onTap: widget.onTap == null
          ? null
          : () {
              // 配置了组，则要判断下同组事件才决定是不是触发点击事件
              if (widget.group != null) {
                var noLock = _simpleButtonGroupLocks.add(widget.group!);
                if (!noLock) {
                  return;
                }
              }
              if (widget.tapTime == SimpleButtonTapTime.WhenTap) {
                widget.onTap?.call();
              }
              if (!controller.isAnimating) {
                if (widget.tapTime == SimpleButtonTapTime.BeforeAnim) {
                  widget.onTap?.call();
                }
                playAnim().then((value) {
                  if (widget.group != null) {
                    _simpleButtonGroupLocks.remove(widget.group);
                  }
                  if (widget.tapTime == SimpleButtonTapTime.AfterAnim) {
                    widget.onTap?.call();
                  }
                });
              }
            },
      child: ScaleTransition(
        scale: scale,
        child: widget.child,
      ),
    );
  }

  Future playAnim() {
    if (controller.isAnimating) {
      return Future.value();
    }
    return controller.play().then((value) => controller.playReverse());
  }
}

/// 时间触发时机
/// [BeforeAnim] 动画播放前
/// [AfterAnim] 动画播放完
/// [WhenTap] 是要 onTap 就触发
enum SimpleButtonTapTime { BeforeAnim, AfterAnim, WhenTap }

// SimpleButton 支持组配置，同组内的按键同时只能触发一个，其他都会被忽略
Set<Object> _simpleButtonGroupLocks = Set<Object>();

class SimpleButtonAnimController {
  Function()? play;
}
