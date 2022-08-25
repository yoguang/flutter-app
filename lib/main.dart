import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'list.dart';

AudioPlayer audioPlayer = AudioPlayer();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pages = [
    const MyHomePage(title: '首頁'),
    const DetailPage(),
    const SecondScreen()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page), label: '发现'),
          BottomNavigationBarItem(icon: Icon(Icons.padding), label: '我的')
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        backgroundColor: const Color(0xff333333),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      currentIndex = currentIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Menu = const [
      HomeMenuItem(
        Icons.calendar_month,
        text: '每日推荐',
      ),
      HomeMenuItem(
        Icons.radio,
        text: '私人FM',
      ),
      HomeMenuItem(
        Icons.playlist_play,
        text: '歌单',
      ),
      HomeMenuItem(
        Icons.list_sharp,
        text: '排行榜',
      ),
      HomeMenuItem(
        Icons.book,
        text: '有声书',
      ),
      HomeMenuItem(
        Icons.book,
        text: '有声书',
      ),
      HomeMenuItem(
        Icons.book,
        text: '有声书',
      ),
      HomeMenuItem(
        Icons.book,
        text: '有声书',
      ),
      HomeMenuItem(
        Icons.book,
        text: '有声书',
      ),
    ];
    List<Widget> playList = const [
      Player(),
      Player(),
      Player(),
      Player(),
      Player(),
      Player(),
      Player(),
      Player(),
      Player(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 117, 112, 114),
                size: 16,
              ),
              label: Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: const Text('给我一首歌的时间',
                    style: TextStyle(
                        color: Color.fromARGB(255, 117, 112, 114),
                        fontSize: 12)),
              ),
              onPressed: () => {print('search onPressed')},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 68, 64, 65))),
            ),
            const Icon(Icons.mic_rounded),
          ],
        ),
        backgroundColor: const Color(0xff363233),
      ),
      drawer: const MyDrawer(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff363233), Color(0xff1e1e1e)]), //背景渐变
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 340,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Stack(
                        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                        children: <Widget>[
                          Image.asset('images/cover.jpg',
                              width: 340, fit: BoxFit.cover),
                          const Positioned(
                            right: 0,
                            bottom: 0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.red,
                                  ],
                                ), //
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 4,
                                ),
                                child: Text(
                                  "热歌推荐",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: Menu,
                    ),
                  ),
                ),
                const Recommend(),
                Artists(),
                // 音乐列表
                Center(
                  child: Column(
                    children: playList,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

// 侧边抽屉菜单
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff151515),
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  const Text(
                    "Wendux",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Add account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Manage accounts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMenuItem extends StatefulWidget {
  const HomeMenuItem(this.icon, {Key? key, required this.text})
      : super(key: key);
  final IconData icon;
  final String text;
  @override
  State<HomeMenuItem> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipOval(
            clipBehavior: Clip.antiAlias,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff603231), Color(0xff603231)]), //背景渐变
              ),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  widget.icon,
                  color: const Color(0xffe33c3b),
                ),
              ),
            ),
          ),
          Text(
            widget.text,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    );
  }
}

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _Player();
}

class _Player extends State<Player> {
  bool _palying = false;
  PlayerState _state = PlayerState.stopped;

  void play() async {
    if (_state == PlayerState.stopped) {
      await audioPlayer.play(AssetSource('ThinkAgain.mp3'));
      PlayerState state = audioPlayer.state;
      if (state == PlayerState.playing) {
        // success
        print('play success');
        _state = state;
      } else {
        print('play failed');
      }
    } else if (_state == PlayerState.playing) {
      await audioPlayer.pause();
      _state = audioPlayer.state;
    } else if (_state == PlayerState.paused) {
      await audioPlayer.resume();
      _state = audioPlayer.state;
    }
    setState(() {
      _palying = _state == PlayerState.playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide.none,
            right: BorderSide.none,
            bottom: BorderSide(
              width: 0.1,
              color: Colors.white,
            ),
            left: BorderSide.none),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(
          left: 16,
          top: 6,
          right: 16,
          bottom: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                'images/avatar.png',
                width: 36,
                height: 36,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 6),
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Maps',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ' - MADILYN',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '百万红心',
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: play,
              icon: _palying
                  ? const Icon(
                      Icons.pause_circle_outline,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: const Center(
        child: Text('我的页面'),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('無限列表'),
      ),
      body: const Center(
        child: InfiniteListView(),
      ),
    );
  }
}

class Recommend extends StatelessWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '推荐歌单',
                style: TextStyle(color: Colors.white),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      bottom: BorderSide(
                        width: 0.1,
                        color: Colors.white,
                      ),
                      left: BorderSide.none),
                ),
                child: Text(
                  '更多',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 72,
                  height: 106,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          width: 72,
                          height: 72,
                          'http://p1.music.126.net/rdOH6YgFt5bUM_qTON0bSw==/109951167748859276.jpg',
                        ),
                      ),
                      const Positioned(
                        width: 72,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          '皇后乐队不得不听的50首经典',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              size: 10,
                              color: Colors.white,
                            ),
                            Text(
                              '57万',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 72,
                  height: 106,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          width: 72,
                          height: 72,
                          'https://p2.music.126.net/UUvNtN1Ip5GwsIerUMMdpw==/109951165370623429.jpg',
                        ),
                      ),
                      const Positioned(
                        width: 72,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          '皇后乐队不得不听的50首经典',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              size: 10,
                              color: Colors.white,
                            ),
                            Text(
                              '57万',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 72,
                  height: 106,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          width: 72,
                          height: 72,
                          'http://p1.music.126.net/rdOH6YgFt5bUM_qTON0bSw==/109951167748859276.jpg',
                        ),
                      ),
                      const Positioned(
                        width: 72,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          '皇后乐队不得不听的50首经典',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              size: 10,
                              color: Colors.white,
                            ),
                            Text(
                              '57万',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 72,
                  height: 106,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          width: 72,
                          height: 72,
                          'https://p2.music.126.net/UUvNtN1Ip5GwsIerUMMdpw==/109951165370623429.jpg',
                        ),
                      ),
                      const Positioned(
                        width: 72,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          '皇后乐队不得不听的50首经典',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              size: 10,
                              color: Colors.white,
                            ),
                            Text(
                              '57万',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Artists extends StatefulWidget {
  const Artists({Key? key}) : super(key: key);

  @override
  State<Artists> createState() => _Artists();
}

class _Artists extends State<Artists> {
  List<ArtistsItem> artists = [];

  request() async {
    if (artists.isNotEmpty) return;
    try {
      var response = await Dio(BaseOptions(responseType: ResponseType.json))
          .get('https://music.163.com/api/artist/list');
      var data = jsonDecode(response.data)['artists'] as List<dynamic>;
      List<ArtistsItem> list = [];
      for (var item in data) {
        var text =
            '${item['name']} ${item['alias'].isNotEmpty ? item['alias'][0] : ""}';
        list.add(ArtistsItem(item['picUrl'], text, ''));
      }
      setState(() {
        artists = list.sublist(0, 4);
      });
      print(artists);
    } catch (error) {
      print('请求错误：$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    request();
    return Container(
      width: 340,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '推荐歌手',
                style: TextStyle(color: Colors.white),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      bottom: BorderSide(
                        width: 0.1,
                        color: Colors.white,
                      ),
                      left: BorderSide.none),
                ),
                child: Text(
                  '更多',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: artists,
            ),
          ),
        ],
      ),
    );
  }
}

class ArtistsItem extends StatelessWidget {
  const ArtistsItem(this.imageUrl, this.text, this.mask, {Key? key})
      : super(key: key);

  final String imageUrl;
  final String text;
  final String mask;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 106,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
              width: 72,
              height: 86,
              imageUrl,
            ),
          ),
          Positioned(
            width: 72,
            left: 0,
            bottom: 0,
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          Positioned(
            top: 18,
            right: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  mask,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
