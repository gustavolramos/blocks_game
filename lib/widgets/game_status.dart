import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:blocks_game/controllers/controller.dart';
import 'package:blocks_game/enums.dart';

class GameStatus extends StatefulWidget {
  const GameStatus({super.key, required this.controller});

  final Controller controller;

  @override
  State<GameStatus> createState() => _GameStatusState();
}

class _GameStatusState extends State<GameStatus> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        IconData icon;
        String text;
        switch (widget.controller.gameState) {
          case GameState.notStarted:
            icon = Icons.stop_circle;
            text = 'Game Not Started';
            break;
          case GameState.playing:
            icon = Icons.sports_esports;
            text = 'Playing';
            break;
          case GameState.finished:
            icon = Icons.done;
            text = 'Game Over';
            break;
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8.0),
              Text(text, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade700)),
            ],
          ),
        );
      },
    );
  }
}
