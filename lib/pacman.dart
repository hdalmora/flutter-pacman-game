import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'game_map.dart';

class PacMan extends Game with VerticalDragDetector, HorizontalDragDetector {
  Size screenSize;
  final gameColumns = 19;
  final gameRows = 18;
  double tileWidth, tileHeight;

  VoidCallback onStateChanged;
  VoidCallback onPlayerDead;

  GameMap gameMap;

  PacMan({
    this.onStateChanged,
    this.onPlayerDead,
  }) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    gameMap = GameMap(this);
  }


  @override
  void render(Canvas canvas) {
    if (this.screenSize == null) {
      return;
    }

    if(gameMap != null)
      gameMap.render(canvas);
  }

  @override
  void update(double t) {
    if(gameMap != null)
      gameMap.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileHeight = (screenSize.height / 1.5) / gameRows;
    tileWidth = (screenSize.width) / gameColumns;
    
    double mazeWidth = tileWidth * gameColumns;
    double mazeHeight = tileHeight * gameRows;
    Size mazeSize = Size(mazeWidth, mazeHeight);

    super.resize(mazeSize);
  }

  @override
  void onVerticalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;

    if(velocity < 0) {
      // up
      gameMap.managePlayerMovement("DOWN");
    } else {
      // down
      gameMap.managePlayerMovement("UP");
    }
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;

    if(velocity < 0) {
      // left
      gameMap.managePlayerMovement("LEFT");
    } else {
      // right
      gameMap.managePlayerMovement("RIGHT");
    }
  }
}