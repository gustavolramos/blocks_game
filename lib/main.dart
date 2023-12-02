import 'package:flutter/material.dart';
import 'package:sisterly_game_challenge/game_board.dart';
import 'package:sisterly_game_challenge/theme.dart';

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
