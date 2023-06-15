import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jooxclone_jittabun/model/ui_modeldata.dart';
// import 'package:jooxclone_jittabun/data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double baseWidth = 430;
  Color? bgColor = Colors.black;

  List<AlbumCard> albumCards = getAlbumCardData();
  List<SuggestData> suggestData = getSuggestData();
  List<Artist> artistsData = getArtistsData();
  List<DailyData> dailyData = getDailyData();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // height: 5,
                  fontSize: 28 * fem,
                ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150 * fem,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: albumCards.length,
                  itemBuilder: (context, index) {
                    final item = albumCards[index];
                    return buildcard(index, item);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10 * fem,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 38 * fem,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconwithtext(
                      Colors.green.shade300, Icons.music_note, "Playlists"),
                  iconwithtext(Colors.purple.shade300, Icons.mic, "Karaoke"),
                  iconwithtext(Colors.red.shade300,
                      Icons.multitrack_audio_outlined, "Live"),
                  iconwithtext(Colors.green.shade300, Icons.videocam, "Buzz"),
                  iconwithtext(Colors.orange.shade200,
                      Icons.radio_button_checked, "Radio"),
                ],
              ),
              coverpic(),
              SizedBox(
                height: 35 * fem,
              ),
              Row(
                children: [
                  maintitle("Thailand Top Charts [31.0...  "),
                  iconwithbg()
                ],
              ),
              SizedBox(
                height: 20 * fem,
              ),
              SizedBox(
                height: 120 * fem,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return topchartcard();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10 * fem,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30 * fem,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  maintitle("แนะนำโดย [ แปะหัวใจ (14... "),
                  Icon(
                    Icons.refresh,
                    size: 22 * fem,
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(4, 3, 6, 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white54)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.play_arrow,
                              size: 12 * fem, color: Colors.white54),
                          Text(
                            'Play all',
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.normal,
                              fontSize: 14 * fem,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15 * fem,
              ),
              SizedBox(
                child: SizedBox(
                  height: 200 * fem,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: suggestData.length,
                    itemBuilder: (context, index) {
                      final item = suggestData[index];
                      return suggestcard(index, item);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20 * fem,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20 * fem,
              ),
              Row(
                children: [
                  maintitle("Daily Playlist "),
                  iconwithbg(),
                  Expanded(child: SizedBox()),
                  Icon(Icons.more_horiz),
                  SizedBox(
                    width: 10 * fem,
                  )
                ],
              ),
              SizedBox(
                height: 20 * fem,
              ),
              SizedBox(
                height: 150 * fem,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dailyData.length,
                  itemBuilder: (context, index) {
                    final item = dailyData[index];
                    return buildcard(index, item);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10 * fem,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topchartcard() {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return Row(
      children: [
        Container(
          width: 300,
          color: const Color.fromRGBO(73, 73, 133, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: const AssetImage('assets/pic/pai.jpg'),
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.8),
                                BlendMode.modulate,
                              ))),
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.crown,
                            size: 12 * fem,
                            color: Colors.brown,
                          ),
                          SizedBox(
                            width: 5 * fem,
                          ),
                          Text(
                            "Vote Now",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Text(
                      "Daily Popularity",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * fem,
                      ),
                    ),
                    Text(
                      "Ranking",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * fem,
                      ),
                    ),
                    SizedBox(
                      height: 7 * fem,
                    ),
                    Row(
                      children: [
                        Text(
                          "1 ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13 * fem,
                          ),
                        ),
                        Text(
                          "PaiPai ป๊ายปาย โอริโอ",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13 * fem,
                              color: Colors.white54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7 * fem,
                    ),
                    Row(
                      children: [
                        Text(
                          "2 ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13 * fem,
                          ),
                        ),
                        Text(
                          "Sunnee",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13 * fem,
                              color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget maintitle(String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22 * fem,
      ),
    );
  }

  Widget iconwithbg() {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return Stack(
      children: [
        Container(
          width: 15 * fem,
          height: 15 * fem,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
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
    );
  }

  Widget iconwithtext(Color bgcolor, IconData icon, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return SizedBox(
      width: 78 * fem,
      height: 90 * fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 30 * fem,
                height: 30 * fem,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bgcolor,
                ),
                child: Center(
                  child: Icon(
                    size: 27 * fem,
                    icon,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7 * fem,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14 * fem,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  Widget coverpic() {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return Stack(
      children: [
        Image.asset(
          "assets/pic/covernew.jpg",
          fit: BoxFit.fitWidth,
          height: 70 * fem,
        ),
        Column(
          children: [
            SizedBox(
              height: 30 * fem,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 75 * fem,
                        height: 17 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white60,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 7 * fem,
                            ),
                            Icon(
                              Icons.headphones,
                              size: 12 * fem,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 3 * fem,
                            ),
                            Text(
                              "ฟังเพลงเลย",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 8 * fem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildcard(int index, final item) {
    Color? textColor = Colors.white60;
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return SizedBox(
      height: 150 * fem,
      width: 140 * fem,
      child: Stack(
        children: [
          Image.asset(
            item.image,
            height: 150 * fem,
            width: 140 * fem,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5 * fem,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17 * fem,
                        ),
                      ),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15 * fem,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    children: [
                      SizedBox(
                        height: 7 * fem,
                      ),
                      Icon(
                        Icons.play_circle,
                        size: 30 * fem,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 2 * fem,
                  ),
                ],
              ),
              SizedBox(
                height: 5 * fem,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget suggestcard(int index, final item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fem = screenWidth / baseWidth;
    return SizedBox(
      // height: 120,

      width: 300 * fem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item.image1,
                    height: 55 * fem,
                    width: 55 * fem,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(item.title1), Text(item.artist1)],
                  ),
                ],
              ),
              SizedBox(
                height: 10 * fem,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item.image2,
                    height: 55 * fem,
                    width: 55 * fem,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(item.title2), Text(item.artist2)],
                  ),
                ],
              ),
              SizedBox(
                height: 10 * fem,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item.image3,
                    height: 55 * fem,
                    width: 55 * fem,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(item.title3), Text(item.artist3)],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

//   Widget suggestitem(String image, String title, String artist, final item) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fem = screenWidth / baseWidth;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           item.image1,
//           height: 55 * fem,
//           width: 55 * fem,
//           fit: BoxFit.cover,
//         ),
//         SizedBox(
//           width: 10 * fem,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Text(item.title1), Text(item.artist1)],
//         ),
//       ],
//     );
//   }
}
