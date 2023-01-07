import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'login.dart';
import 'appbar.dart';

class FantasySelect extends StatefulWidget {
  const FantasySelect({Key? key}) : super(key: key);

  @override
  _FantasySelectState createState() => _FantasySelectState();
}
class _FantasySelectState extends State<FantasySelect>{
  List selectedPlayers = [];
  num credits=65;
  num player_number=13;
  @override
  Widget build(BuildContext context){
    CollectionReference players = FirebaseFirestore.instance.collection('players');
    return FutureBuilder<DocumentSnapshot>(
      
      
      future: players.doc('players').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map data = snapshot.data!.data() as Map;
          List list=[];
          var players=[];
          data.forEach((k, v) => list.add([k, v]));
          var items=101;
          bool _isPressed = false;
          String title="14-player_number";

          Widget buildButton(BuildContext context, int index){

            void SelectionAction(String player) {
              _isPressed = !_isPressed;
              
                final playerCheck = selectedPlayers.contains(player);
                playerCheck
                  ? selectedPlayers.remove(player)
                  : selectedPlayers.add(player);
                playerCheck                  
                  : credits=credits-list[index][1];
                playerCheck                 
                  : player_number=player_number-1;;                 
            }
            if(player_number<1){
              title="You are done!";
            }
            if(players.contains(list[index])==true){
              return Text("${list[index]} is already chosen");
            }

            else{
              return Column(
                children:[

                TextButton(
                    style: TextButton.styleFrom(primary: _isPressed ? Colors.green:Colors.black), 
                    onPressed: () {
                      if (selectedPlayers.length==13){
                        null;
                      } else {
                      setState(() {
                        if(credits-list[index][1]>player_number){
                          SelectionAction(list[index][0]);
                        }
                      
                      });
                        
                      }
                    },
                    child: Text("Name: ${list[index][0]}, Points: ${list[index][1]}"),
                  
                ),
                ]
              );
            }
            
          }

          void dbInput() {
              setState(() {
              _FantasyHomeState.players = selectedPlayers;
              players = selectedPlayers;
              CollectionReference login = FirebaseFirestore.instance.collection('login');
              login.doc("login").set(
                {LoginPage.user:{'pwd':LoginPage.pwd,'players':selectedPlayers}},
                SetOptions(merge:true),
              );
              Navigator.pop(context);
              });
          }

          return Scaffold(
            appBar: AppBarBase(
              title: "Select Player #${(14-player_number)}, ${(credits)}"),
            body: Column(
              children:[
              Expanded(
                  child:SizedBox(
                    height:800.0,
                    child:Scrollbar(
                    child:ListView.separated(
                      padding:EdgeInsets.all(20),
                      separatorBuilder: (context, index) => SizedBox(height:12),
                      itemCount:items,
                      itemBuilder: (context, index) => buildButton(context, index+1),
                      
                    )
                    )
                  )
              ),
              ElevatedButton(child: Text("Finish Team"), onPressed: dbInput)
              ])         
          );

        }
        return Scaffold(
          body:
          ListView(
            children: <Widget>[
              
              Container(
                alignment: Alignment.bottomCenter,
                child:
                Icon(
                  Icons.sports_cricket_rounded,
                  size:100.0
                ),
              ),
              Container(
                alignment:Alignment.center,
                child: Text("LOADING..."),
              )
              
              
            ]
            
          )
            

            
        );
          }
    ); 
    }
}



class FantasyHome extends StatefulWidget {

  @override
  _FantasyHomeState createState() => _FantasyHomeState();
}

class _FantasyHomeState extends State<FantasyHome>{
  
  static List players=[];
  var result = "${(players)}";
  String status="";
  @override 
  Widget build(BuildContext context){
    CollectionReference login = FirebaseFirestore.instance.collection('login');
    if(players.isEmpty){
      setState(() {
        status="No Current Players";
      });
    }
      else{
      setState(() {
        status="Current Players";
      });
    }
    return FutureBuilder<DocumentSnapshot>(
      
      future: login.doc('login').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map data = snapshot.data!.data() as Map;
          return Scaffold(
          appBar:AppBar(
            title:Text("Your Team", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.red,
            automaticallyImplyLeading: false,
          ),
          body:
          ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: [
                    Text("Current players"),
                    Text("${(data[LoginPage.user]["players"])}"),
                    FloatingActionButton(
                      heroTag: "Add",
                      backgroundColor: Colors.red,
                      onPressed: (){
                        if(data[LoginPage.user]["players"].length!=13){
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>FantasySelect()),
                          );
                        });
                        }                 
                      },
                      tooltip:"Add Player",
                      child: const Icon(Icons.add)

                    ),
                    FloatingActionButton(
                      heroTag: "Refresh",
                      backgroundColor: Colors.red,
                      onPressed:(){
                        setState(() {
                          
                        });
                      },
                      child:Text("Refresh",
                      style:TextStyle(fontSize:12.0)) 
                    ),
                  ],
                ),
              ),
            ],
          )
          );
        }
        return Scaffold(
          body:
          ListView(
            children: <Widget>[
              
              Container(
                alignment: Alignment.bottomCenter,
                child:
                Icon(
                  Icons.sports_cricket_rounded,
                  size:100.0
                ),
              ),
              Container(
                alignment:Alignment.center,
                child: Text("LOADING..."),
              )
              
              
            ]
            
          )
            

            
        );
          }
    );   
  }
}



