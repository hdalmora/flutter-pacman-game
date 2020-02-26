import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter_pacman/pacman.dart';
import 'components/ground.dart';
import 'components/player.dart';
import 'components/wall.dart';

class MapTiles  {
  static const WALL = 1;
  static const GROUND = 0;
}

class GameMap {
  List<List<int>> _mapDefinition = [
    [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1 ],
    [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 9, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0 ,0, 0, 0, 0, 1 ],
    [ 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8 ],
    [ 8, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 8 ],
    [ 1, 3, 1, 3, 1, 0, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 0, 1, 0, 1, 0, 1, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 2, 2, 2, 2, 0, 2, 2, 0, 6, 2, 0, 0, 0, 0, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1 ]
  ];

  final PacMan game;
  Map<Point, Component> _map;
  Player _player;

  GameMap(this.game) {
    _initGameMap();
    _addPlayer();
  }

  void _initGameMap() {
    var gameMap = Map<Point, Component>();
    for(var y = 0; y < _mapDefinition.length; y++) {
      for(var x = 0; x < _mapDefinition[0].length; x++) {
        double posX = game.tileWidth * x;
        double posY = game.tileHeight * y;

        switch(_mapDefinition[y][x]) {
          case MapTiles.WALL:
            gameMap[Point(x, y)] = Wall(game, posX, posY);
          break;
          case MapTiles.GROUND:
            gameMap[Point(x, y)] = Ground(game, posX, posY);
          break;
          default:
            gameMap[Point(x, y)] = Ground(game, posX, posY);

        }
      }
    }
    this._map = gameMap;
  }

  void _addPlayer() {
    if(_map.isNotEmpty) {
      _player = Player(game);
    }
  }

  void render(Canvas c) {
    _map.forEach((position, component) {
      component.render(c);
    });
    _player.render(c);
  }

  void update(double t) {
    _player.update(t);
  }

  void managePlayerMovement(String direction) {

    switch(direction) {
      case "LEFT":
        _movePlayer(-1.0, 0.0);
        break;
      case "RIGHT":
        _movePlayer(1.0, 0.0);
        break;
      case "UP":
        _movePlayer(0.0, 1.0);
        break;
      case "DOWN":
        _movePlayer(0.0, -1.0);
        break;
    }
  }

  void _movePlayer(double offsetX, double offsetY) {

    if(_player.position == null) {
      return;
    }

    Point targetPoint = Point((_player.position.x + offsetX), (_player.position.y + offsetY));

    if(_map[targetPoint] is Wall) {
      return;
    }

//    if (_map[targetPoint] is Ghost) {
//      die();
//    }

    if (targetPoint.x < 0) {
      targetPoint = Point(_player.position.x + game.gameColumns - 1, _player.position.y);
    }

    if (targetPoint.x > game.gameColumns - 1) {
      targetPoint = Point(0, _player.position.y);
    }

    if (targetPoint.y < 0) {
      targetPoint = Point(_player.position.x, _player.position.y + game.gameRows -1);
    }

    if (targetPoint.y > game.gameRows - 1) {
      targetPoint = Point(_player.position.x, _player.position.y - game.gameColumns + 2);
    }

//    if (map[targetPoint] is Food) {
//      points += 10;
//      onStateChanged();
//    }

    _player.targetLocation = targetPoint;
  }
}