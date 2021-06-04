import 'package:flutter/material.dart';

/// 弹出Dialog 动画包装
///
/// ```
/// Widget build(BuildContext context) {
///   return Dialog(
///     insetPadding: EdgeInsets.zero,
///     backgroundColor: Colors.transparent,
///     elevation: 0,
///     child: PopAnimBox(
///       child: child,
///     ),
///   );
/// }
/// ```
class PopAnimBox extends StatefulWidget {
  PopAnimBox({
    required this.child,
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.duraiton = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Curve curve;
  final Duration duraiton;

  @override
  _PopAnimBoxState createState() => _PopAnimBoxState();
}

class _PopAnimBoxState extends State<PopAnimBox> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      lowerBound: 0,
      upperBound: 1.0,
      duration: widget.duraiton,
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
