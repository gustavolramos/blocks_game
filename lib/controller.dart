import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sisterly_game_challenge/utilities.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  Color fallingColor = Colors.pink.shade200;
  int gridSize = 5;

  @observable
  GameState gameState = GameState.notStarted;

  @observable
  late List<List<dynamic>> blockColors = List.generate(gridSize, (index) => List.filled(gridSize, Colors.white));

  @observable
  bool isFalling = false;

  @observable
  int fallingRowIndex = 0;

  @observable
  int fallingColIndex = 0;

  @observable
  int score = 0;

  @action
  alterGameState(GameState newGameState) => gameState = newGameState;

  // Guarantees that everytime a block moves down the column, the previous one becomes white again
  @action
  void _resetPreviousBlock() {
    if (fallingRowIndex - 1 > 0) {
      blockColors[fallingRowIndex - 1][fallingColIndex] = Colors.white;
    }
  }

  // This method initiates the block's falling animation, and potentially calls the "_handleCollision" method
  @action
  void fallingAnimation(int rowIndex, int colIndex) {

    blockColors[rowIndex][colIndex] = fallingColor;
    fallingRowIndex = rowIndex;
    fallingColIndex = colIndex;
    isFalling = true;
    const duration = Duration(seconds: 1);

    Timer.periodic(duration, (timer) {
      if (isFalling) {
        _handleCollision();
      } else {
        _resetPreviousBlock();
        timer.cancel();
      }
    });
  }

  @action
  // This method assures every collision outcome is properly dealt with
  void _handleCollision() {
    // If the block has reached the lowest point possible, stop falling, change colors, and calculate the score
    if (fallingRowIndex == 5 - 1) {
      isFalling = false;
      blockColors[fallingRowIndex][fallingColIndex] = fallingColor;
      _resetPreviousBlock();
      _calculateColoredBlocksScore();
      // If the block has collided below, stop falling, change colors, and calculate the score
    } else if (fallingRowIndex < 5 - 1 && blockColors[fallingRowIndex + 1][fallingColIndex] != Colors.white) {
      isFalling = false;
      blockColors[fallingRowIndex][fallingColIndex] = fallingColor;
      _resetPreviousBlock();
      _calculateColoredBlocksScore();

      // If the block has collided with colored blocks on both sides, creating a "bridge", stop falling, change colors, and calculate the score
    } else if (fallingRowIndex < 5 - 1 &&
        fallingColIndex > 0 &&
        blockColors[fallingRowIndex][fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex][fallingColIndex + 1] != Colors.white) {
      isFalling = false;
      blockColors[fallingRowIndex][fallingColIndex] = fallingColor;
      _resetPreviousBlock();
      _calculateColoredBlocksScore();
      // No collision, continue falling
    } else {
      _resetPreviousBlock();
      fallingRowIndex++;
    }
  }

  @action
  void _calculateColoredBlocksScore() {
    // Get the color of the current block
    Color currentColor = blockColors[fallingRowIndex][fallingColIndex];

    // Case 1: If a colored block is on the lowest row possible, it scores 5 points
    if (fallingRowIndex == 5 - 1 && currentColor != Colors.white) {
      score += 5;
    }

    // Case 2: If a colored block has other colored blocks below it, it scores 5 points + 5 points for each colored block below it
    if (fallingRowIndex < 5 - 1 && blockColors[fallingRowIndex + 1][fallingColIndex] != Colors.white) {
      int coloredBlocksBelow = 0;

      for (int i = fallingRowIndex + 1; i < 5; i++) {
        if (blockColors[i][fallingColIndex] != Colors.white) {
          coloredBlocksBelow++;
        } else {
          break;
        }
      }

      if (coloredBlocksBelow > 0) {
        score += 5 + (5 * coloredBlocksBelow);
      }
    }

    // Case 3: If a colored block formed a bridge with other colored blocks, it's scores 5 points.
    if (fallingRowIndex < 5 - 1 &&
        fallingColIndex > 0 &&
        blockColors[fallingRowIndex][fallingColIndex - 1] != Colors.white &&
        blockColors[fallingRowIndex][fallingColIndex + 1] != Colors.white) {
      score += 5;
    }
  }

  @action
  void _calculateWhiteBlocksScore() {
    // Case 4: All white blocks posistioned below a colored block, score 10 points
    for (int i = 0; i < 5; i++) {
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
  Future<void> showEndGameConfirmationDialog(context) async {
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
  void _endGame() {
    gameState = GameState.finished;
    score = 0;
    blockColors = List.generate(5, (index) => List.filled(5, Colors.white));
  }
}
