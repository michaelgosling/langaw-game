import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flutter/gestures.dart';

/// Following tutorial at https://jap.alekhin.io/game-graphics-and-animation-tutorial-flame-flutter-part-2


void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
  ]);

  LangawGame game = LangawGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}