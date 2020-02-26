import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../pacman.dart';

class Player extends Component {
  Sprite sprite = Sprite('pacman/pacman_idle.png');

  Rect _playerRect;
  PacMan _game;
  Point _position;
  Point _targetLocation;
  bool _died = false;
  int _points = 0;

  set addPoints(int points) {
    _points += points;
  }

  int get points => _points;
  Point get position => _position;
  Rect get rect => _playerRect;
  bool get died => _died;

  set targetLocation (Point targetPoint) {
    _targetLocation = targetPoint;
  }

  Player(PacMan game) {
    this._game = game;
    _position = Point(7.0, 10.0); // starting position

    _playerRect = Rect.fromLTWH((_position.x * game.tileWidth),
        (_position.y * _game.tileHeight), _game.tileWidth / 1.5, _game.tileHeight / 1.5);
  }

  void die() {
    _position = null;
    _died = true;
    _points = 0;
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, _playerRect.inflate(2));
  }

  void update(double t) {

    if(_targetLocation != null ) {
      Offset toTarget = Offset(_targetLocation.x * _game.tileWidth, _targetLocation.y * _game.tileHeight)
          - Offset(_position.x * _game.tileWidth, _position.y * _game.tileHeight);

      _playerRect = _playerRect.shift(toTarget);

      _position = _targetLocation; // update player position with target
      _targetLocation = null;
    }
  }
}