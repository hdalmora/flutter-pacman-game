import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pacman/pacman.dart';

class MainScene extends StatefulWidget {
  static const String routeName = "main_scene";

  @override
  _MainSceneState createState() => _MainSceneState();
}

class _MainSceneState extends State<MainScene> {

  PacMan game;

  final StreamController gamesStarted = StreamController();
  final StreamController resetGame = StreamController();

  @override
  void dispose() {
    gamesStarted.close();
    resetGame.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      child: StreamBuilder(
                        stream: gamesStarted.stream,
                        builder: (context, _) {
                          return Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 10.0, top: 16.0, bottom: 4.0),
                              child: Row(
                                children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 25.0),
                                      child: Text('Score', style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontFamily: '8BitMadness'
                                  ),),
                                    ),
                                  Text(
                                    "${game != null ? game.gameMapController.player.points : "0"}",
                                    style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontFamily: '8BitMadness'
                                  ),),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    Expanded(
                      child: StreamBuilder(
                        stream: resetGame.stream,
                        builder: (context, _) {
                          var newGame = PacMan(
                              onStateChanged: () {
                                gamesStarted.add(const Object());
                              },
                              onPlayerDead: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("GameOver"),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              resetGame.add(const Object());
                                            },
                                            child: Text("Restart"),
                                          ),
                                        ],
                                      );
                                    }
                                );
                              }
                          );

                          if(game != null) {
                            newGame.resize(game.screenSize);
                          }

                          game = newGame;
                          return game.widget;
                        },
                      ),
                    ),

                  ],
                ),
            ),

            Positioned(
              bottom: 70,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Arraste a tela no sentido em que deseja se mover",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: '8BitMadness'
                        ),
                      ),
                      SizedBox(height: 25.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(100),
                            size: 24,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(180),
                            size: 24,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(255),
                            size: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
