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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                child: StreamBuilder(
                  stream: gamesStarted.stream,
                  builder: (context, _) {
                    return Container(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Score', style: TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                            Text(
                              "${game != null ? game.gameMapController.player.points : "0"}",
                              style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              decoration: TextDecoration.none,
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


              Container(
                child: Text("BOTTOM MENU", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
