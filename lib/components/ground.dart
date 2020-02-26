import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Ground extends Component {
  final PacMan game;
  Sprite sprite = Sprite('ground.png');
  Rect groundRect;

  Ground(this.game, double x, double y) {
    groundRect = Rect.fromLTWH(x, y, game.tileWidth, game.tileHeight);
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, groundRect.inflate(2));
  }

  @override
  void update(double t) {
  }
}