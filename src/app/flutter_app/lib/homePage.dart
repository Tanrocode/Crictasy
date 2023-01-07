// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_new, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Home Page", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.red,
        actions: <Widget>[
        FlatButton(
          child:Text("Log Out"),
          onPressed:() {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>LoginPage()),
                );
              });
            }
          
        )
          
      ],
      ),
        
      body: Text("Welcome to our Cricket App!",
      style: TextStyle(color:Colors.black, fontSize: 20),
      ),

    );
  }
}