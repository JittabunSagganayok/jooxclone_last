import 'package:flutter/material.dart';
import 'package:jooxclone_jittabun/views/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

//class for drawer
class _StartPageState extends State<StartPage> {
  int _currentpage = 0;
  // static const _titles = <Widget>[
  //   Text("Discover"),
  //   Text("Search"),
  //   Text("Party"),
  //   Text("Library"),
  //   Text("Account"),
  // ];
  final _bodies = <Widget>[
    // 1. Discover
    HomePage(),
    // 2. search
    Center(
      child: Container(
        width: 150,
        height: 150,
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("KLER"),
            Text("CHANNEL"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/pic/yo.jpg"),
                          fit: BoxFit.fill),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: 70,
                  width: 70,
                  // margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/pic/yo.jpg"),
                          fit: BoxFit.fill),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/pic/yo.jpg"),
                          fit: BoxFit.fill),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    Center(
      child: Text('NOT YET 2'),
    ),
    Center(
      child: Text('NOT YET 3'),
    ),
    Center(
      child: Text('NOT YET 4'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentpage,
        onTap: (index) {
          setState(() {
            _currentpage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.album_rounded),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multitrack_audio_outlined),
            label: "Party",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('9'),
              child: Icon(Icons.person),
            ),
            label: "Account",
          ),
        ],
      ),
      body: _bodies.elementAt(_currentpage),
    );
  }
}
