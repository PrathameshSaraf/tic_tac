import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac/home_screen.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;

  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _borad;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _currentPlayer = "X";
    _borad = List.generate(3, (_) => List.generate(3, (_) => ""));
    _winner = "";
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _currentPlayer = "X";
      _borad = List.generate(3, (_) => List.generate(3, (_) => ""));
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_borad[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _borad[row][col] = _currentPlayer;

      //check for winner
      if (_borad[row][0] == _currentPlayer &&
          _borad[row][1] == _currentPlayer &&
          _borad[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_borad[0][col] == _currentPlayer &&
          _borad[1][col] == _currentPlayer &&
          _borad[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_borad[0][0] == _currentPlayer &&
          _borad[1][1] == _currentPlayer &&
          _borad[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_borad[0][2] == _currentPlayer &&
          _borad[1][1] == _currentPlayer &&
          _borad[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      //switch player
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      //check for tie
      if (!_borad.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "It's a Tie";
      }

      if (_winner != "") {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again",
            title: _winner == "X"
                ? widget.player1 + " Won!"
                : _winner == "O"
                    ? widget.player2 + " Won!"
                    : "It's a Tie",
            btnOkOnPress: () {
              _resetGame();
            })
          ..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 120,
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? widget.player1 + " ($_currentPlayer)"
                            : widget.player2 + " ($_currentPlayer)",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _currentPlayer=="X"?Colors.red:Colors.cyan,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ), itemBuilder: (context,index){
                    int row=index~/3;
                    int col=index%3;
                    return GestureDetector(
                      onTap: ()=>_makeMove(row, col),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF0E1E3A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(_borad[row][col],
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 120,
                            color: _borad[row][col]=="X"?
                                Colors.redAccent:Colors.greenAccent
                          ),),

                        ),
                      ),
                    );
              }),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _resetGame,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    child: Text("Reset Game",style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                    widget.player2="";
                    widget.player1="";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    child: Text("Restart Game",style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
