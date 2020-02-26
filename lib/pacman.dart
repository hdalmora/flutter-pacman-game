import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'game_map.dart';

class PacMan extends BaseGame with VerticalDragDetector, HorizontalDragDetector {
  Size screenSize;
  final gameColumns = 19;
  final gameRows = 18;
  double tileWidth, tileHeight;

  VoidCallback onStateChanged;
  VoidCallback onPlayerDead;

  GameMapController _gameMapController;
  
  GameMapController get gameMapController => _gameMapController;

  PacMan({
    this.onStateChanged,
    this.onPlayerDead,
  }) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    _gameMapController = GameMapController(this);
  }


  @override
  void render(Canvas canvas) {
    if (this.screenSize == null) {
      return;
    }

    if(_gameMapController != null)
      _gameMapController.render(canvas);

    super.render(canvas);
  }

  @override
  void update(double t) {
    if(_gameMapController != null)
      _gameMapController.update(t);

    super.update(t);
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
      _gameMapController.managePlayerMovement("DOWN");
    } else {
      // down
      _gameMapController.managePlayerMovement("UP");
    }
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;

    if(velocity < 0) {
      // left
      _gameMapController.managePlayerMovement("LEFT");
    } else {
      // right
      _gameMapController.managePlayerMovement("RIGHT");
    }
  }
}