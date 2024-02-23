import 'package:assets_audio_player/assets_audio_player.dart';

final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

const _soundPaths = {
  MySounds.roll: 'assets/sounds/dice-roll.mp3',
  MySounds.move: 'assets/sounds/piece-move.mp3',
  MySounds.kill: 'assets/sounds/slice.mp3',
  MySounds.error: 'assets/sounds/error-sound.mp3',
  MySounds.enterHome: 'assets/sounds/enter-home.mp3',
  MySounds.congratulations: 'assets/sounds/congratulations.mp3',
  MySounds.rolledOneThrice: 'assets/sounds/rolled-one-thrice.mp3',
};

void playSound(MySounds sound) {
  final path = _soundPaths[sound]!;

  _player.open(
    Audio(path),
    autoStart: true,
    showNotification: true,
  );
}

enum MySounds {
  roll,
  move,
  kill,
  error,
  enterHome,
  congratulations,
  rolledOneThrice
}
