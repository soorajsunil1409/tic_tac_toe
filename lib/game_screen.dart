import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_screen.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;

  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;

      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      _currentPlayer = (_currentPlayer == "X") ? "O" : "X";

      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "Tie";
      }

      if (_winner != "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          btnOkText: "PlayAgain",
          title: (_winner == "X")
              ? widget.player1 + " Wins!"
              : (_winner == "O")
                  ? widget.player2 + " Wins!"
                  : "Tie!",
          btnOkOnPress: () {
            _resetGame();
          },
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 46, 46),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 110,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? widget.player1 + " ($_currentPlayer)"
                            : widget.player2 + " ($_currentPlayer)",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: (_currentPlayer == "X")
                              ? Color.fromARGB(255, 255, 103, 103)
                              : Color.fromARGB(255, 98, 186, 254),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 114, 114, 114),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(248, 246, 246, 246),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            color: (_board[row][col] == "X")
                                ? Color.fromARGB(255, 255, 103, 103)
                                : Color.fromARGB(255, 98, 186, 254),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _resetGame,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 152, 85),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Reset Game",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 107, 213),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Restart Game",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
