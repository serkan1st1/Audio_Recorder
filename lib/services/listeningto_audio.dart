import 'package:audioplayers/audioplayers.dart';

class ListeningToAudio {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playLinkAudio(String audioUrl) async {
    try {
      await audioPlayer.play(UrlSource(audioUrl));
    } catch (e) {
      print('Error playin Recording : $e');
    }
  }
}