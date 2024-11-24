import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/ThemeProvider.dart';
import '../Provider/GameProvider.dart';

class GameScreens extends StatelessWidget {
  const GameScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.currentTheme == ThemeData.light()
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor: gameProvider.oTurn ? Colors.green : Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _scoreColumn('Player O', gameProvider.oScore),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'VS',
                      style: TextStyle(
                          fontSize: 55,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 20),
                  _scoreColumn('Player X', gameProvider.xScore),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      gameProvider.tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 5, color: Colors.blue),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          gameProvider.displayXO[index],
                          style:
                              const TextStyle(fontSize: 64, color: Colors.blue),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      gameProvider.resultDeclaration,
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: gameProvider.clearBoard,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Play Again!',
                        style: TextStyle(fontSize: 20, color: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreColumn(String player, int score) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(player, style: const TextStyle(color: Colors.white, fontSize: 28)),
        Text(score.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 28)),
      ],
    );
  }
}
