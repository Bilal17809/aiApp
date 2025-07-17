import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static final _player = AudioPlayer();

  static Future<void> play(String assetPath) async {
    try {
      await _player.stop(); // stop previous
      await _player.play(AssetSource(assetPath));
    } catch (e) {

    }
  }
}
