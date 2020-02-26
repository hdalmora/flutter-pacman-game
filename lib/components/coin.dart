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
    coinRect = Rect.fromLTWH(x, y, game.tileWidth/4, game.tileHeight/4);
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
      if(this.rect.contains(game.gameMapController.player.rect.bottomCenter) ||
          this.rect.contains(game.gameMapController.player.rect.bottomLeft)  ||
          this.rect.contains(game.gameMapController.player.rect.bottomRight) ||
          this.rect.contains(game.gameMapController.player.rect.topCenter)   ||
          this.rect.contains(game.gameMapController.player.rect.topLeft)     ||
          this.rect.contains(game.gameMapController.player.rect.topRight)) {
        this.consumed = true;
        //TODO: ADD POINTS TO USER
      }
    }


  }
}