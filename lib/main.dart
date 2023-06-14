import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jooxclone_jittabun/views/audioplayer_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

//audioplayer_marcusng
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //   backgroundColor: Colors.white10,
        //   type: BottomNavigationBarType.fixed,
        //   selectedLabelStyle: TextStyle(
        //     fontSize: 12,
        //   ),
        //   unselectedLabelStyle: TextStyle(
        //     fontSize: 12,
        //   ),
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.white38,
        // ),
      ),
      home: const AudioPlayerScreen(),
      //home: LoginPage(),
    );
  }
}
