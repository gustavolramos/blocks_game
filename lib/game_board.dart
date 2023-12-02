import 'package:flutter/material.dart';
import 'package:sisterly_game_challenge/controller.dart';
import 'package:sisterly_game_challenge/utilities.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset('assets/sisterly_logo.png'),
          ),
          title: Text('Blocks Game - Score: ${_controller.score}'),
          actions: [
            // Display "Start playing" or "End game" button based on the game state
            if (_controller.gameState == GameState.notStarted || _controller.gameState == GameState.finished)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _controller.alterGameState(GameState.playing);
                  },
                  child: const Text('Start playing'),
                ),
              ),
            if (_controller.gameState == GameState.playing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _controller.showEndGameConfirmationDialog(context);
                  },
                  child: const Text('End game'),
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _controller.gridSize,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                int rowIndex = index ~/ _controller.gridSize;
                int colIndex = index % _controller.gridSize;

                return GestureDetector(
                  onTap: () {
                    if (_controller.gameState == GameState.playing && !_controller.isFalling) {
                      _controller.fallingAnimation(rowIndex, colIndex);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black),
                      color: _controller.blockColors[rowIndex][colIndex],
                    ),
                  ),
                );
              },
              itemCount: _controller.gridSize * _controller.gridSize,
            ),
          ),
        ),
      ],
    );
  }
}
