import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sisterly_game_challenge/enums.dart';

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
  ObservableList<Color> blockColors = ObservableList<Color>();

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
  void initializeBlockColors() {
    blockColors = ObservableList<Color>.of(List.filled(gridSize * gridSize, Colors.white));
  }

  @action
  void startGame() {
    _clearBoard();
    gameState = GameState.playing;
    score = 0;
  }

  @action
  void fallingAnimation(int rowIndex, int colIndex, BuildContext context) {
    fallingRowIndex = rowIndex;
    fallingColIndex = colIndex;
    blockColors[rowIndex * gridSize + colIndex] = fallingColor;
    isFalling = true;
    const duration = Duration(milliseconds: 250);

    Timer.periodic(duration, (timer) {
      if (isFalling) {
        _handleCollisionCases(context);
      } else {
        resetPreviousBlock();
        timer.cancel();
      }
    });
  }

  @action
  void resetPreviousBlock() {
    if (fallingRowIndex > 0) {
      blockColors[(fallingRowIndex - 1) * gridSize + fallingColIndex] = Colors.white;
    }
  }

  @action
  void _handleCollision(BuildContext context) {
    isFalling = false;
    blockColors[fallingRowIndex * gridSize + fallingColIndex] = fallingColor;
    resetPreviousBlock();
    _calculateColoredBlocksScore();
    _autoEndGame(context);
  }

  @action
  void handleNoCollision() {
    fallingRowIndex++;
    resetPreviousBlock();
  }

  @action
  void _handleCollisionCases(BuildContext context) {
    // The colored block has collided with the bottom of the screen
    if (fallingRowIndex == gridSize - 1) {
      _handleCollision(context);
      // The colored block has collided with a colored block below it
    } else if (fallingRowIndex < gridSize - 1 && blockColors[(fallingRowIndex + 1) * gridSize + fallingColIndex] != Colors.white) {
      _handleCollision(context);
      // The colored block has formed a bridge with one colored block at each side
    } else if (fallingRowIndex < gridSize - 1 &&
        fallingColIndex > 0 &&
        fallingColIndex < 4 &&
        blockColors[fallingRowIndex * gridSize + fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex * gridSize + fallingColIndex + 1] != Colors.white) {
      _handleCollision(context);
      // The colored block has not yet collided with anything
    } else {
      handleNoCollision();
    }
  }

  @action
  void _calculateColoredBlocksScore() {
    Color currentColor = blockColors[fallingRowIndex * gridSize + fallingColIndex];

    if (fallingRowIndex == gridSize - 1 && currentColor != Colors.white) {
      score += 5;
    } else if (fallingRowIndex < gridSize - 1 && blockColors[(fallingRowIndex + 1) * gridSize + fallingColIndex] != Colors.white) {
      int coloredBlocksBelow = 0;

      for (int i = fallingRowIndex + 1; i < gridSize; i++) {
        if (blockColors[i * gridSize + fallingColIndex] != Colors.white) {
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
        blockColors[fallingRowIndex * gridSize + fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex * gridSize + fallingColIndex + 1] != Colors.white) {
      score += 5;
    }
  }

  @action
  void _calculateWhiteBlocksScore() {
    for (int colIndex = 0; colIndex < gridSize; colIndex++) {
      for (int rowIndex = 1; rowIndex < gridSize; rowIndex++) {
        if (blockColors[rowIndex * gridSize + colIndex] == Colors.white) {
          // Check if there's a colored block above the white block
          for (int i = rowIndex - 1; i >= 0; i--) {
            if (blockColors[i * gridSize + colIndex] != Colors.white) {
              // Found a colored block above the white block
              score += 10;
              break;
            }
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
                gameState = GameState.finished;
                _showFinalScoreDialog(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @action
  void _showFinalScoreDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks for playing!'),
          content: Text(
            'Your Score: $score',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.pink.shade300),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearBoard();
                startGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  // If there are 10 blocks with "fallingColor", the game ends
  void _autoEndGame(BuildContext context) {
    int count = 0;

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (blockColors[i * gridSize + j] == fallingColor) {
          count++;
        }
      }
    }

    if (count >= 10) {
      _calculateWhiteBlocksScore();
      gameState = GameState.finished;
      _showFinalScoreDialog(context);
    }
  }

  @action
  void _clearBoard() {
    blockColors = ObservableList<Color>.of(List.filled(gridSize * gridSize, Colors.white));
  }
}
