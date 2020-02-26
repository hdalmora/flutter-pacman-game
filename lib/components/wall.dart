import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Wall extends Component {
  final PacMan game;
  Sprite sprite = Sprite('wall.png');
  Rect wallRect;

  Wall(this.game, double x, double y) {
    wallRect = Rect.fromLTWH(x, y, game.tileWidth, game.tileHeight);
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, wallRect.inflate(2));
  }

  @override
  void update(double t) {
  }
}