# blocks_game

This project is a game of falling blocks 

- It utilizes Mobx (with code generation) for state management.
- It has a few unit tests and widget tests as well.

# Commands

- Build runner
```bash
dart run build_runner watch --delete-conflicting-outputs
```

- Switch current logo for any platform
```bash
dart run flutter_launcher_icons
```

# Rules

- If a colored block reaches the bottom of the grid, it's worth 5 points
- If a colored block is on top of other colored blocks, it's worth 5 points for each colored block below it
- If a colored block reaches a point where there are colored blocks on each of its horizontal sides, it stops falling
- At the end of the game, if a white block is positioned below a colored block, it's worth 10 points
- When 10 blocks are placed, the game ends