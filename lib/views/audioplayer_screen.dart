import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jooxclone_jittabun/controller/audio_controller.dart';
import 'package:jooxclone_jittabun/fonts/utils.dart';
import 'package:jooxclone_jittabun/model/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioController _audioController = AudioController();
  // static const double baseWidth = 430;

  Stream<PositionData> get _positionDataStream =>
      _audioController.positionDataStream;

  @override
  void initState() {
    super.initState();
    // _audioController.init();
  }

  @override
  void dispose() {
    _audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double baseWidth = 430;
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        //color: Colors.blueAccent,
        //padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              /* stream จาก audioPlayer ที่ set playlist แล้ว */
              stream: _audioController.audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                } else {
                  /* metadata ข้อมูลต่างๆใน data playlist */
                  final metadata = state!.currentSource!.tag as MediaItem;
                  /* ui รูป title artist  */
                  return Stack(
                    children: [
                      bgpictextforaudioplayer(
                        imageUrl: metadata.artUri.toString(),
                        artist: metadata.artist ?? '',
                        title: metadata.title,
                        color: metadata.displaySubtitle ?? '0xff000000',
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20 * fem, 0, 20 * fem, 0),
                        child: Column(
                          children: [
                            uiforaudioplayercontrol(
                                audioPlayer: _audioController.audioPlayer),
                            SizedBox(
                              height: 10 * fem,
                            ),
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                /* ui แถบ ProgressBar  */
                                return uiforaudioplayerprogressbar(
                                    positionData: positionData,
                                    audioController: _audioController);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            // SizedBox(height: 20),
            // StreamBuilder<PositionData>(
            //   stream: _positionDataStream,
            //   builder: (context, snapshot) {
            //     final positionData = snapshot.data;
            //     /* ui แถบ ProgressBar  */
            //     return uiforaudioplayerprogressbar(
            //         positionData: positionData,
            //         audioController: _audioController);
            //   },
            // ),
            // SizedBox(height: 20),
            // /* ui แถบ Controls ปุ่ม play pause เปลี่ยนดพลง */
            // uiforaudioplayercontrol(audioPlayer: _audioController.audioPlayer),
          ],
        ),
      ),
    );
  }
}

class uiforaudioplayerprogressbar extends StatelessWidget {
  const uiforaudioplayerprogressbar({
    super.key,
    required this.positionData,
    required AudioController audioController,
  }) : _audioController = audioController;

  final PositionData? positionData;
  final AudioController _audioController;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      barHeight: 2.5,
      baseBarColor: Colors.grey[600],
      bufferedBarColor: Colors.grey,
      progressBarColor: Colors.green,
      thumbColor: Colors.white,
      timeLabelTextStyle: TextStyle(
        fontSize: 13,
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w400,
      ),
      progress: positionData?.position ?? Duration.zero,
      buffered: positionData?.bufferedPosition ?? Duration.zero,
      total: positionData?.duration ?? Duration.zero,
      onSeek: _audioController.audioPlayer.seek,
    );
  }
}

class uiforaudioplayercontrol extends StatelessWidget {
  const uiforaudioplayercontrol({Key? key, required this.audioPlayer})
      : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    const double baseWidth = 430;
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;

    return Column(
      children: [
        SizedBox(
          height: (height * 0.5) + 170 * fem,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              iconSize: 30,
              color: Colors.white.withOpacity(0.5),
              icon: Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: audioPlayer.seekToPrevious,
              iconSize: 50,
              color: Colors.white,
              icon: Icon(Icons.skip_previous),
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
                    icon: Icon(Icons.play_circle),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: 80,
                    color: Colors.white,
                    icon: Icon(Icons.pause_circle),
                  );
                }
                return const Icon(
                  Icons.play_circle,
                  size: 80,
                  color: Colors.white,
                );
              },
            ),
            IconButton(
              onPressed: audioPlayer.seekToNext,
              iconSize: 50,
              color: Colors.white,
              icon: Icon(Icons.skip_next),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 30,
              color: Colors.white.withOpacity(0.5),
              icon: Icon(Icons.heart_broken_outlined),
            ),
          ],
        ),
        SizedBox(
          height: 10 * fem,
        ),
      ],
    );
  }
}

class bgpictextforaudioplayer extends StatelessWidget {
  const bgpictextforaudioplayer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.color,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String artist;
  final String color;

  @override
  Widget build(BuildContext context) {
    Color? colorbg;
    int colorValue = int.parse(color);
    colorbg = Color(colorValue);
    const double baseWidth = 430;
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    double height = MediaQuery.of(context).size.height;
    return
        // Column(
        //   children: [
        //     ClipRect(
        //       child: CachedNetworkImage(
        //         imageUrl: imageUrl,
        //         height: 300,
        //         width: 300,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     SizedBox(height: 20),
        //     Text(title),
        //     SizedBox(height: 20),
        //     Text(artist),
        //     Container(
        //       width: 50,
        //       height: 50,
        //       color: colorbg,
        //     ),
        //   ],
        // );
        Stack(
      children: [
        Container(
          color: colorbg.withOpacity(1),
        ),
        ClipRect(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 0.5 * height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0.2 * height, 0, 0),
          child: Container(
            height: 0.3 * height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                colorbg.withOpacity(1),

                colorbg.withOpacity(0),
                // Colors.white.withOpacity(0.5)
              ],
              stops: [0.0, 1],
              begin: Alignment.bottomRight,
            )),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0.5 * height, 0, 0),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(20 * fem, 10 * fem, 20 * fem, 20 * fem),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: SafeGoogleFont(
                        'kanit',
                        fontSize: 24 * fem,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    SizedBox(
                      height: 8 * fem,
                    ),
                    Row(
                      children: [
                        Text(
                          artist,
                          style: SafeGoogleFont(
                            'kanit',
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.w400,
                            height: 1.495,
                            color: const Color(0xffffffff).withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 3 * fem,
                        ),
                        //iconwithbg(),
                        Stack(
                          children: [
                            Container(
                              width: 15 * fem,
                              height: 15 * fem,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffffffff).withOpacity(0.5),
                              ),
                              child: Center(
                                child: Icon(
                                  size: 10 * fem,
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        bordercontainer(fem, "Med"),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        bordercontainer(fem, "Galaxy Sound")
                      ],
                    ),
                    SizedBox(
                      height: 30 * fem,
                    ),
                    Text(
                      "เพลง: ${title}",
                      style: SafeGoogleFont(
                        'kanit',
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600,
                        height: 1.495,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    Text(
                      "ศิลปิน: ${artist}",
                      style: SafeGoogleFont(
                        'kanit',
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w400,
                        height: 1.495,
                        color: const Color(0xffffffff).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget bordercontainer(double fem, String text) {
  return Container(
    //margin: const EdgeInsets.all(15.0),
    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
    decoration: BoxDecoration(
        border: Border.all(
      color: Color(0xffffffff).withOpacity(0.5),
    )),
    child: Row(
      children: [
        Text(
          text,
          style: SafeGoogleFont(
            'kanit',
            fontSize: 12 * fem,
            fontWeight: FontWeight.w800,
            //height: 1.495,
            color: const Color(0xffffffff).withOpacity(0.7),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        //iconwithbgsmall(),
        Stack(
          children: [
            Container(
              width: 8 * fem,
              height: 8 * fem,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffffffff).withOpacity(0.5),
              ),
              child: Center(
                child: Icon(
                  size: 5 * fem,
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
