import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sisterly_game_challenge/controllers/controller.dart';
import 'package:sisterly_game_challenge/widgets/app_bar.dart';
import 'package:sisterly_game_challenge/widgets/game_status.dart';
import 'package:sisterly_game_challenge/enums.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final Controller _controller = Controller();

  @override
  void initState() {
    super.initState();
    _controller.initializeBlockColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(controller: _controller), 
      body: Column(
        children: [
          GameStatus(controller: _controller),
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
                  return Observer(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        if (_controller.gameState == GameState.playing && _controller.isFalling == false) {
                          _controller.fallingAnimation(rowIndex, colIndex, context);
                        }
                      },
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black),
                          color: _controller.blockColors[rowIndex * _controller.gridSize + colIndex],
                        ),
                      ),
                    );
                  });
                },
                itemCount: _controller.gridSize * _controller.gridSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
