import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainScene.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PacMan Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: '8BitMadness',
      ),
      initialRoute: MainScene.routeName,
      routes: {
        MainScene.routeName: (context) => MainScene(),
      },
    );
  }

}