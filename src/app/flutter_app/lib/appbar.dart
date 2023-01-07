import 'package:flutter/material.dart';

import 'login.dart';


class AppBarBase extends StatefulWidget with PreferredSizeWidget{
  const AppBarBase({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  _AppBarBaseState createState() => _AppBarBaseState(title: title);

  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarBaseState extends State<AppBarBase>  {
  _AppBarBaseState({ Key? key, required this.title });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title:Text(title, style: TextStyle(color: Colors.black),),
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
      ]
    );
  }

}