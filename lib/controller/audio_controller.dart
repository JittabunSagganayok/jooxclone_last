import 'package:jooxclone_jittabun/model/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioController {
  String uri;
  String title;
  String displaySubtitle;
  String artist;
  String artUri;

  late AudioPlayer _audioPlayer;
  // late AudioController _audioController;

  AudioController(
    this.uri,
    this.title,
    this.displaySubtitle,
    this.artist,
    this.artUri,
  ) {
    _audioPlayer = AudioPlayer();
    init(uri, title, displaySubtitle, artist, artUri);
  }

//method 1. set ค่า playlist
  Future<void> init(
    String uri,
    String title,
    String displaySubtitle,
    String artist,
    String artUri,
  ) async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    final playlist =
        AudioModel.getPlaylist(uri, title, displaySubtitle, artist, artUri);
    await _audioPlayer.setAudioSource(playlist);
  }

//method 2. set ค่า แถบเล่นเพลง
  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

//method  ปิดเพลง
  void dispose() {
    _audioPlayer.dispose();
  }

//method get audioPlayer
  AudioPlayer get audioPlayer => _audioPlayer;
}



//เอา positiondata มาใช้ ด้วย controller