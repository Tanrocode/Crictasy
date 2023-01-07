import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'dart:async';

class Entering extends StatefulWidget {
  const Entering({ Key? key }) : super(key: key);

  @override
  _EnteringState createState() => _EnteringState();
}

class _EnteringState extends State<Entering> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
  }
  
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: FadeTransition(
        opacity: _animation,
        child: Column(children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 300), child: Icon(Icons.sports_cricket_sharp, size: 75, color: Colors.red,)),
          Padding(padding: EdgeInsets.only(bottom: 25.0),
          child: Text(
            "Getting Things Ready", 
            style: TextStyle(fontSize: 15, color: Colors.red, )
              )
            ),
          ], 
        ),
      )
    );
  }
}
class LoginPage extends StatefulWidget{
  @override 
  static var user=_LoginPageState.user;
  static var pwd= _LoginPageState.pwd;
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  
  String title="Login";
  String other_title="Sign Up";
  String msg="";
  final myController=TextEditingController();
  final myControllerPwd=TextEditingController();
  static var user="";
  static var pwd="";
  @override 
  Widget build(BuildContext context){
    CollectionReference login = FirebaseFirestore.instance.collection('login');

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
          
          
          
          Widget buildMessage(BuildContext context) {
            return Text("${(msg)}");
          }  
          Widget buildUsername(BuildContext context){
            return TextField(
              decoration:InputDecoration(
                border:OutlineInputBorder(),
                hintText:"Enter Username"
              ),
              controller:myController,
            );
          }
          Widget buildPassword(BuildContext context){
            return TextField(
              decoration:InputDecoration(
                border:OutlineInputBorder(),
                hintText:"Enter Password",
              ),
              obscureText: true,
              controller:myControllerPwd,
            );
          }
          Widget buildSwitch(BuildContext context){
            return FlatButton(
              child: Text("${(other_title)}",
              style:TextStyle(color:Colors.blue)),
              onPressed:() {
                setState(() {
                  String temp=other_title;
                  other_title=title;
                  title=temp;
                  msg="";
                  myController.text="";
                  myControllerPwd.text="";
                });
              }
            );
          }
          Widget buildEnter(BuildContext context){
            return FlatButton(
              child:Text("Enter"),
              onPressed:() {
                if(title=="Login"){
                  try{
                    if(data[myController.text]['pwd']==myControllerPwd.text){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>StartingPage()),
                      );
                      user=myController.text;
                      pwd=myControllerPwd.text;
                      setState(() {
                        msg="";
                      });
                    }
                    else{
                      setState(() {
                        msg="Password or Username is Incorrect";
                      });
                      
                    }
                  }catch(Exception){
                    setState(() {
                      msg="Username does not exist";
                    });
                    
                  }
                }
                if(title=="Sign Up"){
                  if(data[myController.text]==null){
                    login.doc("login").set(
                      {myController.text:{'pwd':myControllerPwd.text,'players':[]}},
                      SetOptions(merge:true),
                      );
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>StartingPage()),
                    );
                    setState(() {
                      msg="";
                      user=myController.text;
                      pwd=myControllerPwd.text; 
                    });
                  }
                  else{
                    setState(() {
                      msg="This username already exists";
                    });
                    
                  }
                }
                

              }
            );
          }
            
          


                 
            
          return Scaffold(
            appBar:AppBar(
              automaticallyImplyLeading: false,
      title:Text("Welcome", style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.red,),
            body: Column(
              children:[
              buildMessage(context),
              buildUsername(context),
              buildPassword(context),
              buildSwitch(context),
              buildEnter(context),         


              ]));
        }

        return Entering();

      },
    );
      
      
  }
}