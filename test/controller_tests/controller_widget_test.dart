// This file will contain widget tests for the controller
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sisterly_game_challenge/controllers/controller.dart';
import 'package:sisterly_game_challenge/widgets/app_bar.dart';

void main() {
  late Controller controller;

  setUp(() {
    controller = Controller();
  });

  testWidgets('GameAppBar displays correctly', (WidgetTester tester) async {
    
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
    expect(find.text('Blocks Game - Score: ${controller.score}'), findsOneWidget);

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
}
