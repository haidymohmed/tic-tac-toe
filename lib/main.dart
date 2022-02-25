import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int score_o =0, score_x = 0 ;
  String Current_player = "X" ;
  bool winner = false;
  List<String> _list = List.filled(9, '');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: " X O Game ",
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                flex : 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15 , right: 15 , left: 15 , bottom: 10),
                            child: Center(child: Text("Player X",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "Pacifico"),)),
                          ),
                          Center(child: Text(score_x.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "Pacifico"),)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15 , right: 15 , left: 15 , bottom: 10),
                            child: Center(child: Text("Player O",style: TextStyle(fontFamily: "Pacifico",fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                          Center(child: Text(score_o.toString(),style: TextStyle(fontFamily: "Pacifico" ,fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Congratulations YOU HAVE WON !",
                  style: TextStyle(
                    color: _textColor(),
                    fontFamily: "Pacifico",
                    fontSize: 15
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: double.maxFinite,
                  width: double.infinity,
                  child: GridView.builder(
                    itemCount: _list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context,index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            if(_list[index] == "" && winner == false){
                              _list[index] = Current_player;
                              _ifWin();
                              setScore();
                              _switchPlayer(winner);
                            }
                          });
                        },
                        child: Container(
                          decoration: border(index),
                          margin: EdgeInsets.all(1),
                          child: Center(
                            child: Text(
                              _list[index],
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pacifico"
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.only(top: 15 , bottom: 15, left: 60,right: 60),
                      color: Colors.green,
                      textColor: Colors.white,
                      hoverColor: Colors.green[800],
                      onPressed: () {
                        setState(() {
                          _playAgain();
                        });
                      },
                      child: Text(
                        "Play Again",
                        textScaleFactor: 1.5,
                        style: TextStyle(fontFamily: "Pacifico"),
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.only(top: 15 , bottom: 15, left: 60,right: 60),
                      color: Colors.red,
                      textColor: Colors.white,
                      hoverColor: Colors.red[800],
                      onPressed: () {
                        setState(() {
                          _endGame();
                        });
                      },
                      child: Text(
                        "End Game",
                        textScaleFactor: 1.5,
                        style: TextStyle(fontFamily: "Pacifico"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  void _switchPlayer(bool win){
    if(winner == false){
      if(Current_player == "X"){
        Current_player  = "O";
      }
      else
        Current_player = "X";
    }
  }
  void _ifWin(){
    if((_list[0] == _list[1] && _list[1]== _list[2] && _list[1] == Current_player) || (_list[3] == _list[4] && _list[4]== _list[5] && _list[4] == Current_player) || (_list[6] == _list[7] && _list[7]== _list[8] && _list[7] == Current_player) || (_list[0] == _list[4] && _list[4]== _list[8] && _list[4] == Current_player) || (_list[0] == _list[3] && _list[3]== _list[6] && _list[3] == Current_player) || (_list[1] == _list[4] && _list[4]== _list[7] && _list[4] == Current_player) || (_list[2] == _list[5] && _list[5]== _list[8] && _list[5] == Current_player) || (_list[2] == _list[4] && _list[4]== _list[6] && _list[4] == Current_player))
      winner = true;
    else
      winner = false;
  }
  void setScore(){
    if( winner == true){
      if(Current_player == "X"){
        score_x +=1;
      }
      else
        score_o +=1;
    }
  }
  void _playAgain(){
    for(int i=0;i<_list.length;i++){
      _list[i] = "";
    }
    Current_player = "X";
    winner = false;
  }
  Color _textColor(){
    if(winner == true){
      return Colors.white;
    }
    else
      return Colors.black;
  }
  void _endGame(){
    for(int i=0;i<_list.length; i++){
      _list[i] = "";
    }
    Current_player = "X";
    score_o = 0;
    score_x = 0;
    winner = false;
  }
  BoxDecoration border(int index){
    if(index == 0){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          right: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 1){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          right: BorderSide(width: 2,color: Colors.grey),
          left: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 2){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          left: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 3){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          right: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 4){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          right: BorderSide(width: 2,color: Colors.grey),
          left: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 5){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(width: 2,color: Colors.grey),
          left: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 6){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          right: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else if(index == 7){
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          right: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
          left: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
    else{
      return BoxDecoration(
        color: Colors.black,
        border: Border(
          left: BorderSide(width: 2,color: Colors.grey),
          top: BorderSide(width: 2,color: Colors.grey),
        ),
      );
    }
  }
}
