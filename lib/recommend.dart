import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  static const loadingTag = "##loading##"; //表尾标记
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('每日推荐'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        child: Image.network(
            'https://p1.music.126.net/COXWzpE_qJsoTE8WyY5XNw==/109951167827678314.jpg?imageView&quality=89'),
      ),
      backgroundColor: const Color.fromARGB(255, 95, 60, 101),
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}
