import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

//อธิบาย /**/
class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

//อธิบาย /**/
class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

//อธิบายการ set ข้อมูลจาก playlist ดูตั้งแต่ 3:38
  final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(Uri.parse('asset:///assets/audio/cupid.mp3'),
          tag: MediaItem(
              id: "0",
              title: "Cupid",
              displaySubtitle: "0xffFFC0CB",
              artist: 'FiftyFifty',
              displayDescription: "description1",
              artUri: Uri.parse('https://img.pic.in.th/cupid.jpeg'))),

      AudioSource.uri(Uri.parse('asset:///assets/audio/nightdancer.mp3'),
          tag: MediaItem(
              id: "1",
              title: "Night Dancer",
              artist: 'Imase',
              artUri: Uri.parse('https://img.pic.in.th/nightdancer.jpeg'))),
      //ใส่เป็นลิ้ง url ได้
      //AudioSource.uri(Uri.parse('https://')),
    ],
  );

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_audioPlayer = AudioPlayer()..setAsset('assets/audio/cupid.mp3');
    //..setUrl('');
    //เปลี่ยนเป็นลิ้งURLได้ yt ดูนาที 3:25

    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    //set ข้อมูลจาก playlist
    await _audioPlayer.setAudioSource(_playlist);
    /**/
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.amber,
        // ),
        body: Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //อธิบาย /**/ buffer คือ แถบเทาๆในยูทูปที่โหลดล่วงหน้าไว้ก่อนเล่นวิดิโอ
        children: [
          //อธิบาย Streambuilder (set ค่าให้ image artist url มาแสดง)
          StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                } else {
                  final metadata = state!.currentSource!.tag as MediaItem;
                  return MediaMetadata(
                    imageUrl: metadata.artUri.toString(),
                    artist: metadata.artist ?? '',
                    title: metadata.title,
                    color: metadata.displaySubtitle ?? '0xff000000',
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final PositionData = snapshot.data;
                return ProgressBar(
                  barHeight: 8,
                  baseBarColor: Colors.grey[600],
                  bufferedBarColor: Colors.grey,
                  progressBarColor: Colors.red,
                  thumbColor: Colors.red,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  progress: PositionData?.position ?? Duration.zero,
                  buffered: PositionData?.bufferedPosition ?? Duration.zero,
                  total: PositionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                );
              }),
          SizedBox(
            height: 20,
          ),
          Controls(audioPlayer: _audioPlayer)
        ],
      ),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

//อธิบาย /**/

//Row ของปุ่ม
class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          iconSize: 60,
          color: Colors.white,
          icon: Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 80,
                  color: Colors.white,
                  icon: Icon(Icons.play_arrow_rounded),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 80,
                  color: Colors.white,
                  icon: Icon(Icons.pause_rounded),
                );
              }
              return const Icon(
                Icons.play_arrow_rounded,
                size: 80,
                color: Colors.white,
              );
            }),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          iconSize: 60,
          color: Colors.white,
          icon: Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}

/**/
class MediaMetadata extends StatelessWidget {
  const MediaMetadata(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.artist,
      required this.color});
  final String imageUrl;
  final String title;
  final String artist;
  final String color;

  @override
  Widget build(BuildContext context) {
    Color? colorbg;
    int colorValue = int.parse(color);
    colorbg = Color(colorValue);

    return Column(
      children: [
        ClipRect(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(title),
        SizedBox(
          height: 20,
        ),
        Text(artist),
        Container(
          width: 50,
          height: 50,
          color: colorbg,
        )
      ],
    );
  }
}
