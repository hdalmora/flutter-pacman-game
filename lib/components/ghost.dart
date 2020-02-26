import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_pacman/components/wall.dart';

import '../pacman.dart';

class Ghost extends Component {
  final PacMan game;
  Sprite sprite = Sprite('enemies/ghosts/ghost_1.png');
  Rect ghostRect;

  Point position;

  double elapsedTime = 0;
  Random random = Random();

  Rect get rect => ghostRect;

  Ghost(this.game, double x, double y) {
    position = Point(x, y);
    ghostRect = Rect.fromLTWH(x * game.tileWidth, y * game.tileHeight, game.tileWidth, game.tileHeight);
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, ghostRect.inflate(2));
  }

  @override
  void update(double t) {

    elapsedTime += t;

    if (elapsedTime > .7 ) {

      var oldPosition = position;
      var newPoint;

      do {
        if (random.nextBool()) {
          newPoint = Point<num>(
              oldPosition.x + (random.nextBool() ? 1 : -1), oldPosition.y);
        } else {
          newPoint = Point<num>(
              oldPosition.x, oldPosition.y + (random.nextBool() ? 1 : -1));
        }

        Offset toTarget = Offset(newPoint.x * game.tileWidth, newPoint.y * game.tileHeight)
            - Offset(position.x * game.tileWidth, position.y * game.tileHeight);

        ghostRect = ghostRect.shift(toTarget);
        position = newPoint;
        elapsedTime = 0;
      } while((game.gameMapController.map[newPoint] is Wall || game.gameMapController.map[newPoint] is Ghost) ||
          (newPoint.x > game.gameColumns || newPoint.x < 0 || newPoint.y > game.gameRows || newPoint.y < 0));
    }

    if(!game.gameMapController.player.died) {
      if(game.gameMapController.player.rect.contains(this.rect.bottomCenter) ||
          game.gameMapController.player.rect.contains(this.rect.bottomLeft)  ||
          game.gameMapController.player.rect.contains(this.rect.bottomRight) ||
          game.gameMapController.player.rect.contains(this.rect.topCenter)   ||
          game.gameMapController.player.rect.contains(this.rect.topLeft)     ||
          game.gameMapController.player.rect.contains(this.rect.topRight)) {
        game.die();
      }
    }
  }
}