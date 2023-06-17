import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jooxclone_jittabun/controller/audio_controller.dart';
import 'package:jooxclone_jittabun/fonts/utils.dart';
import 'package:jooxclone_jittabun/model/audio_model.dart';
import 'package:jooxclone_jittabun/model/ui_modeldata.dart';
import 'package:jooxclone_jittabun/views/start_page.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'dart:math' as math;

class AudioPlayerScreen extends StatefulWidget {
  AudioPlayerScreen(
      {Key? key,
      required this.uri,
      required this.title,
      required this.displaySubtitle,
      required this.artist,
      required this.artUri})
      : super(key: key);

  String uri;
  String title;
  String displaySubtitle;
  String artist;
  String artUri;
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  //final AudioController _audioController = AudioController();
  late AudioController _audioController;

  // static const double baseWidth = 430;

  Stream<PositionData> get _positionDataStream =>
      _audioController.positionDataStream;

  @override
  void initState() {
    super.initState();
    // _audioController.init();
    _audioController = AudioController(
      widget.uri,
      widget.title,
      widget.displaySubtitle,
      widget.artist,
      widget.artUri,
    );
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
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize: 30 * fem,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                  onPressed: null,
                                  iconSize: 30 * fem,
                                ),
                              ],
                            ),
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
                            SizedBox(
                              height: 20 * fem,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconwithtext(Icons.repeat, "โหมด"),
                                iconwithtext(Icons.download, "ดาวน์โหลด"),
                                iconwithtext(Icons.comment, "ความคิดเห็น"),
                                iconwithtext(Icons.mic, "ร้องเพลง"),
                                iconwithtext(Icons.share, "แชร์"),
                              ],
                            ),
                            // Expanded(child: SizedBox()),
                            // Container(
                            //   color: metadata.displaySubtitle,
                            //   child: Text(
                            //     "data",
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget iconwithtext(IconData icon, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 430;
    final fem = screenWidth / baseWidth;
    return SizedBox(
      // width: 78 * fem,
      // height: 90 * fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 30 * fem,
                height: 30 * fem,
                decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    //color: bgcolor,
                    ),
                child: Center(
                  child: Icon(
                    size: 28 * fem,
                    icon,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5 * fem,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 12 * fem,
                fontWeight: FontWeight.w200,
                color: Colors.white.withOpacity(0.9)),
          )
        ],
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
          height: (height * 0.5) + 70 * fem,
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

    int darkenAmount = 20; // Adjust this value to make the color darker

    int red = (colorbg.red + darkenAmount).clamp(0, 255);
    int green = (colorbg.green + darkenAmount).clamp(0, 255);
    int blue = (colorbg.blue + darkenAmount).clamp(0, 255);

    Color colorbottom = Color.fromARGB(colorbg.alpha, red, green, blue);
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
        Column(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(25, 10, 35, 0),
                color: colorbottom,
                height: 55 * fem,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("เลื่อนขึ้นเพื่อดูรายละเอียดเพลง"),
                    Stack(
                      children: [
                        Opacity(
                          opacity: 1,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://cdn3.iconfinder.com/data/icons/faticons/32/arrow-up-01-512.png",
                            //height: 5,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://cdn3.iconfinder.com/data/icons/faticons/32/arrow-up-01-512.png",
                                //height: 25,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          ],
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
