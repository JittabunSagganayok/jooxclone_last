// //ไล่สีเสร็จแล้วอย่าไปยุ่ง

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:joox_clone_app/fonts/utils.dart';

// class AudioplayerPage extends StatefulWidget {
//   const AudioplayerPage({super.key});

//   @override
//   State<AudioplayerPage> createState() => _AudioplayerPageState();
// }

// class _AudioplayerPageState extends State<AudioplayerPage> {
//   static const double baseWidth = 430;
//   /**/ final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;

// /**/ @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//      setAudio();
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.PLAYING;
//       });
//     });
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }

/**/
// Future setAudio() async {
//   audioPlayer.setReleaseMode(kReleaseMode.LOOP);
// final player = AudioCache(prefix:'assets/audio/');
// final url = await player.load('cupid.mp3');
// audioPlayer.setUrl(url.path,isLocal:true);
// }

//   /**/ @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fem = screenWidth / baseWidth;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Color(0xff84180c).withOpacity(1),
//           ),
//           Container(
//             height: 0.5 * height,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/pic/fifty.png"),
//                     //scale: 0.5,
//                     fit: BoxFit.cover)),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 0.2 * height, 0, 0),
//             child: Container(
//               height: 0.3 * height,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                 colors: [
//                   Color(0xff84180c).withOpacity(1),

//                   Color(0xff84180c).withOpacity(0),
//                   // Colors.white.withOpacity(0.5)
//                 ],
//                 stops: [0.0, 1],
//                 begin: Alignment.bottomRight,
//               )),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 0.5 * height, 0, 0),
//             child: Padding(
//               padding:
//                   EdgeInsets.fromLTRB(20 * fem, 10 * fem, 20 * fem, 20 * fem),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Cupid",
//                     style: SafeGoogleFont(
//                       'kanit',
//                       fontSize: 24 * fem,
//                       fontWeight: FontWeight.w600,
//                       height: 1.0,
//                       color: const Color(0xffffffff),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 8 * fem,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "FIFTY FIFTY",
//                         style: SafeGoogleFont(
//                           'kanit',
//                           fontSize: 18 * fem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.495,
//                           color: const Color(0xffffffff).withOpacity(0.5),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 3 * fem,
//                       ),
//                       iconwithbg(),
//                       SizedBox(
//                         width: 10 * fem,
//                       ),
//                       bordercontainer(fem, "Med"),
//                       SizedBox(
//                         width: 10 * fem,
//                       ),
//                       bordercontainer(fem, "Galaxy Sound")
//                     ],
//                   ),
//                   SizedBox(
//                     height: 30 * fem,
//                   ),
//                   Text(
//                     "datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata",
//                     style: SafeGoogleFont(
//                       'kanit',
//                       fontSize: 18 * fem,
//                       fontWeight: FontWeight.w400,
//                       //height: 1.495,
//                       color: const Color(0xffffffff).withOpacity(0.5),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25 * fem,
//                   ),
//                   /**/
//                   Slider(
//                       min: 0,
//                       max: duration.inSeconds.toDouble(),
//                       value: position.inSeconds.toDouble(),
//                       onChanged: (value) async {
//                         final position =Duration(seconds:value.toInt());
//                          await audioPlayer.seek(position);
//                            await audioPlayer.resume(); 
//                      }),
//                   /**/
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(formatTime(position)),
//                       Text(formatTime(duration - position))
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25 * fem,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Image.asset(
//                       //   "assets/pic/pause.png",
//                       //   //fit: BoxFit.fitWidth,
//                       //   //height: 70 * fem,
//                       // ),
//                       //
//                       /**/ CircleAvatar(
//                         radius: 35,
//                         child: IconButton(
//                           icon:
//                               Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                           iconSize: 50,
//                           onPressed: () async {
//                             if (isPlaying) {
//                               await audioPlayer.pause();
//                             } else {
//                              // String url =
//                             //     "https://www.chosic.com/wp-content/uploads/2021/02/Fluffing-a-Duck.mp3";
//                               await audioPlayer.play(url);
//                             }
//                           },
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Container bordercontainer(double fem, String text) {
//     return Container(
//       //margin: const EdgeInsets.all(15.0),
//       padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
//       decoration: BoxDecoration(
//           border: Border.all(
//         color: Color(0xffffffff).withOpacity(0.5),
//       )),
//       child: Row(
//         children: [
//           Text(
//             text,
//             style: SafeGoogleFont(
//               'kanit',
//               fontSize: 12 * fem,
//               fontWeight: FontWeight.w800,
//               //height: 1.495,
//               color: const Color(0xffffffff).withOpacity(0.7),
//             ),
//           ),
//           SizedBox(
//             width: 3,
//           ),
//           iconwithbgsmall(),
//         ],
//       ),
//     );
//   }

//   Widget iconwithbg() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fem = screenWidth / baseWidth;
//     return Stack(
//       children: [
//         Container(
//           width: 15 * fem,
//           height: 15 * fem,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffffffff).withOpacity(0.5),
//           ),
//           child: Center(
//             child: Icon(
//               size: 10 * fem,
//               Icons.arrow_forward_ios,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget iconwithbgsmall() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fem = screenWidth / baseWidth;
//     return Stack(
//       children: [
//         Container(
//           width: 8 * fem,
//           height: 8 * fem,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffffffff).withOpacity(0.5),
//           ),
//           child: Center(
//             child: Icon(
//               size: 5 * fem,
//               Icons.arrow_forward_ios,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

// /**/
//   String formatTime(Duration position) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(':');
//   }
// }

// /**/
// enum PlayerState {
//   STOPPED,
//   PAUSED,
//   PLAYING,
//   COMPLETED,
// }
