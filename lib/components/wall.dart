import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Wall extends Component {
  final PacMan game;
  Sprite sprite;
  Rect wallRect;

  Wall(String spritePath, this.game, double x, double y) {
    sprite = Sprite(spritePath);
    wallRect = Rect.fromLTWH(x, y, game.tileWidth/1.1, game.tileHeight/1.1);
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, wallRect.inflate(2));
  }

  @override
  void update(double t) {
  }
}