// This file will contain unit tests for the controller
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:sisterly_game_challenge/controllers/controller.dart';
import 'package:sisterly_game_challenge/enums.dart';

void main() {
  late Controller controller;

  setUp(() {
    controller = Controller();
  });

  test('When the initializeBlockColors action is called, the blockColors observble is filled with 25 white colored blocks ', () {
    controller.initializeBlockColors();
    expect(controller.blockColors, List<Color>.filled(controller.gridSize * controller.gridSize, Colors.white));
  });

  test('When the startGame action is called, the gameState observable is changed to "GameState.playing", and the score observable becomes zero', () {
    controller.startGame();
    expect(controller.gameState, GameState.playing);
    expect(controller.score, 0);
  });

  test('When the resetPreviousBlock action is called, the block above the current block has its color changed back to white ', () {
    controller.blockColors = ObservableList<Color>.of([Colors.white, Colors.pink, Colors.white]);
    controller.resetPreviousBlock();
    expect(controller.blockColors, [Colors.white, Colors.white, Colors.white]);
  });

  test('When the handleNoCollision, the value of fallingRowIndex increases by one and the resetPreviousBlock action is called once', () {
    controller.fallingRowIndex = 0;
    controller.handleNoCollision();
    expect(controller.fallingRowIndex, 1);
  });
}
