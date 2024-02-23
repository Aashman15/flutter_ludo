import 'package:assets_audio_player/assets_audio_player.dart';

final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

const _soundPathPrefix = 'assets/sounds';

const _soundPaths = {
  MySounds.roll: '$_soundPathPrefix/dice-roll.mp3',
  MySounds.move: '$_soundPathPrefix/piece-move.mp3',
  MySounds.kill: '$_soundPathPrefix/slice.mp3',
  MySounds.error: '$_soundPathPrefix/error-sound.mp3',
  MySounds.enterHome: '$_soundPathPrefix/enter-home.mp3',
  MySounds.congratulations: '$_soundPathPrefix/congratulations.mp3',
  MySounds.rolledOneThrice: '$_soundPathPrefix/rolled-one-thrice.mp3',
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
