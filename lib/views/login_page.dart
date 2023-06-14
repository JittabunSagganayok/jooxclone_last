import 'package:jooxclone_jittabun/views/home_page.dart';
import 'package:jooxclone_jittabun/views/start_page.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/loginvid.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0.0);
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              //fittedbox ทำให้ vdo ขนาดเข้ากับหน้าจอ รูปแบบ fit.cover
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          loginWidget()
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget loginWidget() {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    Color fbColor = const Color(0xff1778F2);
    Color textColor = Colors.white;
    String logolink = 'https://cdn.i-joox.com/static/di/joox-logo-white.png';

    return Padding(
      padding: EdgeInsets.all(25.0 * fem),
      child: Column(
        children: [
          SizedBox(
            height: 75 * fem,
          ),
          Center(
            child: Image.network(
              logolink,
              height: 45 * fem,
            ),
          ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StartPage()),
                //StartPage
              );
            },
            child: Container(
              height: 40 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * fem),
                color: fbColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20 * fem,
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/pic/fblogof.jpg',
                      width: 20 * fem,
                    ),
                  ),
                  SizedBox(
                    width: 55 * fem,
                  ),
                  Text(
                    'Facebook ',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 16 * fem,
                    ),
                  ),
                  Text(
                    '(Recent login)',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12 * fem,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(80 * fem, 20 * fem, 70 * fem, 20 * fem),
            child: Row(
              children: [
                iconwithtext(
                  textColor,
                  "https://cdn-icons-png.flaticon.com/512/10273/10273094.png",
                  "Mobile",
                  fem,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                iconwithtext(
                  textColor,
                  "https://cdn.onlinewebfonts.com/svg/img_503976.png",
                  "Email",
                  fem,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3675/3675672.png',
                width: 12 * fem,
                color: Colors.white,
              ),
              Text(
                " I agree to the ",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12 * fem,
                ),
              ),
              Text(
                "Terms of Service,",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12 * fem,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30 * fem,
              ),
              Text(
                "JOOX User Terms",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14 * fem,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text(
                " and ",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12 * fem,
                ),
              ),
              Text(
                "Privacy Policy",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12 * fem,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * fem,
          ),
        ],
      ),
    );
  }

  Widget iconwithtext(
      Color textColor, String iconImageUrl, String text, double fem) {
    return Column(
      children: [
        Image.network(
          iconImageUrl,
          width: 40 * fem,
          color: Colors.white,
          opacity: const AlwaysStoppedAnimation(.7),
        ),
        SizedBox(
          height: 3 * fem,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 14 * fem,
          ),
        ),
      ],
    );
  }
}
