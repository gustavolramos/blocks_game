import 'package:flutter/material.dart';
import 'package:blocks_game/controllers/controller.dart';
import 'package:blocks_game/enums.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key, required this.controller});

  final Controller controller;

  // This is needed to implement PreferredSizeWidget and subsititute the regular appBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset('assets/flutter_logo.png'),
          ),
          title: Text('Blocks - Score: ${controller.score}'),
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
