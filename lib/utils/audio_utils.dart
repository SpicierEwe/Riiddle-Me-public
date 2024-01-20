import 'package:audioplayers/audioplayers.dart';
import 'package:riddle_me/constants/variable_constants.dart';

class CustomAudioUtils {
  AudioPlayer audioPlayer = AudioPlayer();

  void playRevealSound() {
    audioPlayer.play(AssetSource(VariableConstants.revealSoundLink));
  }

  void playHintSound() {
    audioPlayer.play(AssetSource(VariableConstants.hintSoundLink));
  }

  void playHintsFinishedSound() {
    audioPlayer.play(AssetSource(VariableConstants.hintsFinishedSoundLink));
  }
}
