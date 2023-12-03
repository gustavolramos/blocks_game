import 'package:flutter/material.dart';
import 'package:sisterly_game_challenge/controller.dart';
import 'package:sisterly_game_challenge/utilities.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key, required this.controller});

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset('assets/sisterly_games_logo.png'),
          ),
          title: Text('Blocks Game - Score: ${controller.score}'),
          actions: [
            if (controller.gameState == GameState.notStarted || controller.gameState == GameState.finished)
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.startGame();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start playing'),
                  )),
            if (controller.gameState == GameState.playing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.showEndGameConfirmationDialog(context);
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('End game'),
                ),
              ),
          ],
        );
      },
    );
  }
}