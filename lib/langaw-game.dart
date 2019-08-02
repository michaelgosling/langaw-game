import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:langaw/components/fly.dart';
import 'package:langaw/components/backyard.dart';
import 'package:langaw/components/house-fly.dart';
import 'package:langaw/components/agile-fly.dart';
import 'package:langaw/components/drooler-fly.dart';
import 'package:langaw/components/hungry-fly.dart';
import 'package:langaw/components/macho-fly.dart';

class LangawGame extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard bg;

  LangawGame() { initialize(); }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    bg = Backyard(this);
    spawnFly();
  }

  void render(Canvas canvas) {

    // Background
    bg.render(canvas);

    // Flies
    flies.forEach((Fly f) => f.render(canvas));

  }

  void update(double t) {
    flies.forEach((Fly f) => f.update(t));
    flies.removeWhere((Fly f) => f.isOffScreen);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);

    flies.add(getNewFly(x, y));
  }

  Fly getNewFly(double x, double y) {
    switch (rnd.nextInt(5)) {
      case 0:
        return HouseFly(this, x, y);
      case 1:
        return DroolerFly(this, x, y);
      case 2:
        return AgileFly(this, x, y);
      case 3:
        return MachoFly(this, x, y);
      case 4:
      default:
        return HungryFly(this, x, y);
    }
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly f) {
      if (f.flyRect.contains(d.globalPosition)) f.onTapDown();
    });
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

  }
}