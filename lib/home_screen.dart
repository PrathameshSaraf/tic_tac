import 'package:flutter/material.dart';
import 'package:tic_tac/GameScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  final TextEditingController player1Controller=TextEditingController();
  final TextEditingController player2Controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       backgroundColor: Color(0xFF323D5B),
      body: Form(
        key: _formkey, child:
      Column(
        children: [
          SizedBox(height: 80,),
          Text("Enter Players Name",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.all(20),
          child:TextFormField(
            controller: player1Controller,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                )
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  )
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  )
              ),
              hintText: "Player 1 Name",
              hintStyle: TextStyle(color: Colors.white),
            ),
           validator: (value){
              if(value==null || value.isEmpty){
                return "Please enter Player 1 Name";
              }
              return null;
           },
          )
            ,),

          Padding(padding: EdgeInsets.all(20),
            child:TextFormField(
              controller: player2Controller,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                ),
                hintText: "Player 2 Name",
                hintStyle: TextStyle(color: Colors.white),
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Please enter Player 2 Name";
                }
                return null;
              },
            )
            ,),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
               if(_formkey.currentState!.validate() ){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>GameScreen(player1: player1Controller.text, player2: player2Controller.text)));
               }
            },child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 17,horizontal: 20),
            child: Text("Start Game",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),),
          ),
          ),
        ],
      ),
        
      ),
    );
  }
}
