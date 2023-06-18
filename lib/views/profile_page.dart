import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jooxclone_jittabun/model/ui_modeldata.dart';
import 'package:jooxclone_jittabun/views/audioplayer_screen.dart';
// import 'package:jooxclone_jittabun/data/data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // height: 5,
                  fontSize: 28 * fem,
                ),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 20 * fem,
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.all(20.0 * fem),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                  radius: 30,
                ),
                SizedBox(
                  width: 20 * fem,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jittabun Sagganayok",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // height: 5,
                          fontSize: 18 * fem,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Text(
                      "ID : 65130413",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          // height: 5,
                          fontSize: 14 * fem,
                          color: Colors.white.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Row(
                      children: [
                        Text(
                          "0  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // height: 5,
                              fontSize: 12 * fem,
                              color: Colors.white),
                        ),
                        Text(
                          "Followers  | ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // height: 5,
                              fontSize: 12 * fem,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        Text(
                          "  1  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // height: 5,
                              fontSize: 12 * fem,
                              color: Colors.white),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // height: 5,
                              fontSize: 12 * fem,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.diamond_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Subscriptions & Benefits",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Row(
              children: [
                Icon(
                  Icons.radio_button_checked,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Coins & Income",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Tasks & Rewards",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Row(
              children: [
                Icon(
                  Icons.class_,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Theme Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Row(
              children: [
                Icon(
                  Icons.note_alt_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Feedback",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15 * fem,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // height: 5,
                      fontSize: 16 * fem,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
