// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on ControllerBase, Store {
  late final _$gameStateAtom =
      Atom(name: 'ControllerBase.gameState', context: context);

  @override
  GameState get gameState {
    _$gameStateAtom.reportRead();
    return super.gameState;
  }

  @override
  set gameState(GameState value) {
    _$gameStateAtom.reportWrite(value, super.gameState, () {
      super.gameState = value;
    });
  }

  late final _$blockColorsAtom =
      Atom(name: 'ControllerBase.blockColors', context: context);

  @override
  List<List<Color>> get blockColors {
    _$blockColorsAtom.reportRead();
    return super.blockColors;
  }

  @override
  set blockColors(List<List<Color>> value) {
    _$blockColorsAtom.reportWrite(value, super.blockColors, () {
      super.blockColors = value;
    });
  }

  late final _$isFallingAtom =
      Atom(name: 'ControllerBase.isFalling', context: context);

  @override
  bool get isFalling {
    _$isFallingAtom.reportRead();
    return super.isFalling;
  }

  @override
  set isFalling(bool value) {
    _$isFallingAtom.reportWrite(value, super.isFalling, () {
      super.isFalling = value;
    });
  }

  late final _$fallingRowIndexAtom =
      Atom(name: 'ControllerBase.fallingRowIndex', context: context);

  @override
  int get fallingRowIndex {
    _$fallingRowIndexAtom.reportRead();
    return super.fallingRowIndex;
  }

  @override
  set fallingRowIndex(int value) {
    _$fallingRowIndexAtom.reportWrite(value, super.fallingRowIndex, () {
      super.fallingRowIndex = value;
    });
  }

  late final _$fallingColIndexAtom =
      Atom(name: 'ControllerBase.fallingColIndex', context: context);

  @override
  int get fallingColIndex {
    _$fallingColIndexAtom.reportRead();
    return super.fallingColIndex;
  }

  @override
  set fallingColIndex(int value) {
    _$fallingColIndexAtom.reportWrite(value, super.fallingColIndex, () {
      super.fallingColIndex = value;
    });
  }

  late final _$scoreAtom = Atom(name: 'ControllerBase.score', context: context);

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  late final _$showEndGameConfirmationDialogAsyncAction = AsyncAction(
      'ControllerBase.showEndGameConfirmationDialog',
      context: context);

  @override
  Future<void> showEndGameConfirmationDialog(BuildContext context) {
    return _$showEndGameConfirmationDialogAsyncAction
        .run(() => super.showEndGameConfirmationDialog(context));
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  void _resetPreviousBlock() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._resetPreviousBlock');
    try {
      return super._resetPreviousBlock();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _handleCollision(BuildContext context) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._handleCollision');
    try {
      return super._handleCollision(context);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _handleNoCollision() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._handleNoCollision');
    try {
      return super._handleNoCollision();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _handleCollisionCases(BuildContext context) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._handleCollisionCases');
    try {
      return super._handleCollisionCases(context);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fallingAnimation(int rowIndex, int colIndex, BuildContext context) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.fallingAnimation');
    try {
      return super.fallingAnimation(rowIndex, colIndex, context);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _calculateColoredBlocksScore() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._calculateColoredBlocksScore');
    try {
      return super._calculateColoredBlocksScore();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _calculateWhiteBlocksScore() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._calculateWhiteBlocksScore');
    try {
      return super._calculateWhiteBlocksScore();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _showEndGameDialog(BuildContext context) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._showEndGameDialog');
    try {
      return super._showEndGameDialog(context);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startGame() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.startGame');
    try {
      return super.startGame();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _endGame() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase._endGame');
    try {
      return super._endGame();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gameState: ${gameState},
blockColors: ${blockColors},
isFalling: ${isFalling},
fallingRowIndex: ${fallingRowIndex},
fallingColIndex: ${fallingColIndex},
score: ${score}
    ''';
  }
}
