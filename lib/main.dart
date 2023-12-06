import 'package:flutter/material.dart';
import 'package:blocks_game/game_board.dart';
import 'package:blocks_game/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GameBoard(),
      theme: standardTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
