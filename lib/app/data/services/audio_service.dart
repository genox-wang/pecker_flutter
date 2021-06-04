import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

/// 音效服务
///
/// 在 `init` 中预先缓存音频文件
/// ```
/// AudioService.to.play('error.mp3')
/// ```
class AudioService extends GetxService {
  static AudioService get to => Get.find();

  late AudioCache _cache;

  /// 由于 audioplayers 使用 AudioCache.play() 播放音效，播放完成之后会 release。如果音效播放过于频繁会由于内存垃圾过多导致卡顿，甚至卡死，所以在设置一个缓存之来维护 AudioPlayer，让它们可以复用
  Map<String, Map<String, dynamic>> _pool = Map<String, Map<String, dynamic>>();

  final int maxPool = 10;

  final Random random = Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void onClose() {
    _cache.clearAll();
    super.onClose();
  }

  Future<AudioService> init() async {
    _cache = AudioCache(prefix: 'assets/audio/', duckAudio: true);
    // _cache.loadAll([
    //   "error.mp3",
    //   'note_status_change.mp3',
    //   'number_tap.mp3',
    // ]);
    return this;
  }

  AudioPlayer get _audioPlayer {
    if (_pool.length < maxPool) {
      final audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

      _pool[audioPlayer.playerId] = {
        'audioPlayer': audioPlayer,
        'stop': false,
      };
      audioPlayer.onPlayerCompletion.listen((event) {
        _pool[audioPlayer.playerId]?['stop'] = true;
      });
      audioPlayer.setReleaseMode(
        ReleaseMode.STOP,
      );
      return audioPlayer;
    }
    for (var d in _pool.values) {
      if (d['stop']) {
        return d['audioPlayer'];
      }
    }

    int index = random.nextInt(maxPool);

    final audioPlayer = _pool.values.toList()[index]['audioPlayer'];
    return audioPlayer;
  }

  play(String fileName) {
    final uri = _cache.loadedFiles[fileName];
    if (uri != null) {
      _audioPlayer.stop();
      _audioPlayer.play(uri.path, volume: 0.5);
      _pool[_audioPlayer.playerId]?['stop'] = false;
    }
  }
}
