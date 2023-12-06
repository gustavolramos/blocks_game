// This file will contain widget tests for the controller
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blocks_game/controllers/controller.dart';
import 'package:blocks_game/enums.dart';
import 'package:blocks_game/widgets/app_bar.dart';
import 'package:blocks_game/widgets/game_status.dart';

void main() {
  late Controller controller;

  setUp(() {
    controller = Controller();
  });

  testWidgets('GameAppBar widget displays correct information based on game state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameAppBar(controller: controller),
        ),
      ),
    );

    // Verify that the logo is present.
    expect(find.byType(Image), findsOneWidget);

    // Verify that the title contains the initial score.
    expect(find.text('Blocks - Score: ${controller.score}'), findsOneWidget);

    // Verify that the "Start playing" button is present when the game is not started or finished.
    expect(find.text('Start playing'), findsOneWidget);

    // Verify that the "End game" button is not present initially.
    expect(find.text('End game'), findsNothing);

    // Start the game.
    controller.startGame();
    await tester.pump();

    // Verify that the "End game" button is present when the game is in progress.
    expect(find.text('End game'), findsOneWidget);
  });

  testWidgets('GameStatus widget displays correct information based on game state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GameStatus(controller: controller),
          ],
        ),
      ),
    ));

    // Verify that the initial state is displayed
    expect(find.text('Game Not Started'), findsOneWidget);
    expect(find.byIcon(Icons.stop_circle), findsOneWidget);

    // Change the game state to playing
    controller.startGame();
    await tester.pump();

    expect(find.text('Playing'), findsOneWidget);
    expect(find.byIcon(Icons.sports_esports), findsOneWidget);

    // Change the game state to finished
    controller.gameState = GameState.finished;
    await tester.pump();

    expect(find.text('Game Over'), findsOneWidget);
    expect(find.byIcon(Icons.done), findsOneWidget);
  });
}
