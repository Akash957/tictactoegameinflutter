import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  bool oTurn = true;
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;

  void tapped(int index) {
    if (displayXO[index] == '' && !winnerFound) {
      displayXO[index] = oTurn ? 'O' : 'X';
      filledBoxes++;
      oTurn = !oTurn;
      checkWinner();
    }
    notifyListeners();
  }

  void checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ];

    for (var pattern in winPatterns) {
      if (displayXO[pattern[0]] == displayXO[pattern[1]] &&
          displayXO[pattern[0]] == displayXO[pattern[2]] &&
          displayXO[pattern[0]] != '') {
        resultDeclaration = 'Player ${displayXO[pattern[0]]} Wins!';
        updateScore(displayXO[pattern[0]]);
        winnerFound = true;
        notifyListeners();
        return;
      }
    }

    if (!winnerFound && filledBoxes == 9) {
      resultDeclaration = 'Nobody Wins!';
    }
    notifyListeners();
  }

  void updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    notifyListeners();
  }

  void clearBoard() {
    displayXO = ["", "", "", "", "", "", "", "", ""];
    resultDeclaration = '';
    filledBoxes = 0;
    winnerFound = false;
    notifyListeners();
  }
}
