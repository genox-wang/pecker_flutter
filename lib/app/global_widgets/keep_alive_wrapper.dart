import 'package:flutter/material.dart';

/// KeepAlive 包装
///
/// ```
/// PageView(
///   children: [
///     KeepAliveWrapper(child: GameHallView()),
///    `KeepAliveWrapper(child: BattleHallView()),
///     KeepAliveWrapper(child: DailyChallengeRankView()),
///   ],
/// )
/// ```
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  KeepAliveWrapper({required this.child});

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
