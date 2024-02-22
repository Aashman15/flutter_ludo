import 'package:assets_audio_player/assets_audio_player.dart';


final AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();

void playSound(String sound) {
  if (sound == 'error') {
    player.open(
      Audio("assets/sounds/error-sound.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }
  if (sound == 'roll') {
    player.open(
      Audio("assets/sounds/dice-roll.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

  if (sound == 'move') {
    player.open(
      Audio("assets/sounds/piece-move.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

  if (sound == 'kill') {
    player.open(
      Audio("assets/sounds/slice.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

  if (sound == 'enterHome') {
    player.open(
      Audio("assets/sounds/enter-home.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

  if (sound == 'congratulations') {
    player.open(
      Audio("assets/sounds/congratulations.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

  if(sound == 'rolledOneThrice'){
    player.open(
      Audio("assets/sounds/rolled-one-thrice.mp3"),
      autoStart: true,
      showNotification: true,
    );
    return;
  }

}


