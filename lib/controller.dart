import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sisterly_game_challenge/utilities.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  Color fallingColor = Colors.pink.shade200;
  int gridSize = 5;

  // @observables are state variables that should only be modified by @actions
  // Once their value changes, the Observer widget is notified and rebuilds whatever is necessary

  @observable
  GameState gameState = GameState.notStarted;

  @observable
  late List<List<Color>> blockColors = List.generate(gridSize, (index) => List.filled(gridSize, Colors.white));

  @observable
  bool isFalling = false;

  @observable
  int fallingRowIndex = 0;

  @observable
  int fallingColIndex = 0;

  @observable
  int score = 0;

  // An @action is simply a method that modifies @observables

  @action
  void _resetPreviousBlock() {
    if (fallingRowIndex > 0) {
      blockColors[fallingRowIndex - 1][fallingColIndex] = Colors.white;
    }
  }

  @action
  void _handleCollision(BuildContext context) {
    isFalling = false;
    blockColors[fallingRowIndex][fallingColIndex] = fallingColor;
    _resetPreviousBlock();
    _calculateColoredBlocksScore();
    _autoEndGame(context);
  }

  @action
  void _handleNoCollision() {
    fallingRowIndex++;
    _resetPreviousBlock();
  }

  @action
  void _handleCollisionCases(BuildContext context) {
    // The colored block has collided with the bottom of the screen
    if (fallingRowIndex == gridSize - 1) {
      _handleCollision(context);
      // The colored block has collided with a colored block below it
    } else if (fallingRowIndex < gridSize - 1 && blockColors[fallingRowIndex + 1][fallingColIndex] != Colors.white) {
      _handleCollision(context);
      // The colored block has formed a bridge with one colored block at each side
    } else if (fallingRowIndex < gridSize - 1 &&
        fallingColIndex > 0 &&
        fallingColIndex < 4 &&
        blockColors[fallingRowIndex][fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex][fallingColIndex + 1] != Colors.white) {
      _handleCollision(context);
      // The colored block has not yet collided with anything
    } else {
      _handleNoCollision();
    }
  }

  @action
  void fallingAnimation(int rowIndex, int colIndex, BuildContext context) {
    blockColors[rowIndex][colIndex] = fallingColor;
    fallingRowIndex = rowIndex;
    fallingColIndex = colIndex;
    isFalling = true;
    const duration = Duration(seconds: 1);

    Timer.periodic(duration, (timer) {
      if (isFalling) {
        _handleCollisionCases(context);
      } else {
        _resetPreviousBlock();
        timer.cancel();
      }
    });
  }

  @action
  void _calculateColoredBlocksScore() {
    Color currentColor = blockColors[fallingRowIndex][fallingColIndex];

    if (fallingRowIndex == gridSize - 1 && currentColor != Colors.white) {
      score += 5;
    } else if (fallingRowIndex < gridSize - 1 && blockColors[fallingRowIndex + 1][fallingColIndex] != Colors.white) {
      int coloredBlocksBelow = 0;

      for (int i = fallingRowIndex + 1; i < gridSize; i++) {
        if (blockColors[i][fallingColIndex] != Colors.white) {
          coloredBlocksBelow++;
        } else {
          break;
        }
      }

      if (coloredBlocksBelow > 0) {
        score += 5 + (5 * coloredBlocksBelow);
      }
    } else if (fallingRowIndex < gridSize - 1 &&
        fallingColIndex > 0 &&
        blockColors[fallingRowIndex][fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex][fallingColIndex + 1] != Colors.white) {
      score += 5;
    }
  }

  @action
  void _calculateWhiteBlocksScore() {
    for (int i = 0; i < gridSize; i++) {
      if (blockColors[i][fallingColIndex] != Colors.white) {
        for (int j = i - 1; j >= 0; j--) {
          if (blockColors[j][fallingColIndex] == Colors.white) {
            score += 10;
          } else {
            break;
          }
        }
      }
    }
  }

  @action
  Future<void> showEndGameConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _calculateWhiteBlocksScore();
                _endGame();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @action
  void _showEndGameDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks for playing!'),
          content: Text('Your Score: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text('Play Again?'),
            ),
          ],
        );
      },
    );
  }

  @action
  void startGame() {
    gameState = GameState.playing;
    score = 0;
  }

  @action
  void _endGame() {
    gameState = GameState.finished;
    blockColors = List.generate(gridSize, (index) => List.filled(gridSize, Colors.white));
  }

  // If there are 10 blocks with "fallingColor", the game ends
  void _autoEndGame(BuildContext context) {
    int count = 0;

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (blockColors[i][j] == fallingColor) {
          count++;
        }
      }
    }

    if (count >= 10) {
      _endGame();
      _showEndGameDialog(context);
    }
  }
}
