import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../pacman.dart';

class Coin extends Component {
  final PacMan game;
  Sprite sprite = Sprite('coin.png');
  Rect coinRect;
  bool _consumed;

  set consumed(bool consumed) {
    _consumed = consumed;
  }

  Rect get rect => coinRect;

  Coin(this.game, double x, double y) {
    coinRect = Rect.fromLTWH(x + (8 * game.tileWidth) / 20, y + (8 * game.tileHeight) / 20, game.tileWidth/10, game.tileHeight/10);
    _consumed = false;
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, coinRect.inflate(2));
  }

  @override
  void update(double t) {
    if(_consumed) {
      game.gameMapController.addCoinToRemove = this;

    } else {
      if(!game.gameMapController.player.died) {
        if(game.gameMapController.player.rect.contains(this.rect.bottomCenter) ||
            game.gameMapController.player.rect.contains(this.rect.bottomLeft)  ||
            game.gameMapController.player.rect.contains(this.rect.bottomRight) ||
            game.gameMapController.player.rect.contains(this.rect.topCenter)   ||
            game.gameMapController.player.rect.contains(this.rect.topLeft)     ||
            game.gameMapController.player.rect.contains(this.rect.topRight)) {
          this.consumed = true;
          game.addPoints();
        }
      }
    }
  }
}