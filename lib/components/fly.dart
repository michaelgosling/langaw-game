import 'dart:ui';
import 'package:langaw/langaw-game.dart';
import 'package:flame/sprite.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Fly(this.game) {
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) deadSprite.renderRect(c, flyRect.inflate(2));
    else flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
  }

  void update(double t) {
    // Death or flying animation logic
    if (isDead)
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
    else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) flyingSpriteIndex -= 2;
    }

    // Move logic
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }

    // Cleanup off screen fly logic
    isOffScreen = !isOffScreen && flyRect.top > game.screenSize.height;
  }

  void onTapDown() {
    isDead = true;
    game.spawnFly();
  }
}