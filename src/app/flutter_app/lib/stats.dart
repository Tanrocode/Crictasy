// ignore_for_file: prefer_const_constructors, unnecessary_new



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main.dart';


class StatsHome extends StatefulWidget {
  const StatsHome({Key? key}) : super(key: key);

  @override
  _StatsHomeState createState() => _StatsHomeState();
}

class _StatsHomeState extends State<StatsHome> {
  String dropdownValue="2021";
  int _value=1;
  int value=0;
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Stats",
            style:TextStyle(color:Colors.black)
            ),

            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.red,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black, 
              indicatorWeight: 5,
                // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                Tab(text: "Bowling "), 
                Tab(text: "Batting ")
              ]
            ),
          ),
          
          
          body: TabBarView(
            children: [
              StatsPage(title: "wicketdata", name: "WICKET DATA",items:50,year:"2021"), 
              StatsPage(title: "rundata", name: "RUN DATA", items:60, year:"2021")],
          )
      ),
    );
  }
}
class StatsPage extends StatefulWidget {
  const StatsPage({Key? key, required this.title, required this.name, required this.items, required this.year}) : super(key: key);
  final String title;
  final String name;
  final int items;
  final String year;
  @override
  _StatsPageState createState() => _StatsPageState(title:title,name:name,items:items,year:year);
}
class _StatsPageState extends State<StatsPage> {
  _StatsPageState({Key? key, required this.title, required this.name, required this.items, required this.year});

  String dropdownValue="2021";
  final String title;
  final String name;
  final int items;
  String year;
  
  
  // ignore: non_constant_identifier_name
  List headers = ["Position","Player Name","Matches","Innings","Not Outs","Runs","Highest Score","Average","Balls Faced","Strike Rate","100's","50's","Fours","Sixes"];
  List headers1 = ["Position","Player Name","Matches","Innings","Overs","Runs","Wickets","Best Bowling Innings","Average","Economy","Bowling Strike Rate","4 wickets","5 wickets"];

  Widget columnMake(data, index) {
    List<Widget> columns = <Widget>[];
    if (title == "rundata") {
      for (int i = 0; i < 14; i++) {
            if (title == "rundata")
              columns.add(Text("${headers[i]} - ${data["$index"][headers[i]]}", style: TextStyle(color: Colors.red),));
            
      }
    }
    if (title == "wicketdata") {
      for (int i = 0; i < 13; i++) {
              columns.add(Text("${headers1[i]} - ${data["$index"][headers1[i]]}", style: TextStyle(color: Colors.red),));
            
      }
    }
    return Column(children: columns);
  }
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    CollectionReference run_data = FirebaseFirestore.instance.collection('${title}');
     return FutureBuilder<DocumentSnapshot>(
      
      future: run_data.doc('${(year)}').get(),
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
          data=data[name];
          
          
          Widget buildDropdown(BuildContext context) {
            return DropdownButton<String>(
              
              menuMaxHeight: 200.0,
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.red),
              underline: Container(
                height: 2,
                color: Colors.red,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  year=newValue;
                });
              },
              items: <String>['2021', '2020', '2019', '2018','2017','2016','2015','2014','2013','2012','2011','2010','2009','2008']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }  
          Widget buildCard(int index)=> 
            Card(
              color:Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                    
                    child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),  
                    iconColor: Colors.red,
                    collapsedIconColor: Colors.red,
                    title: Text(
                      " ${index}: ${data["$index"]["Player Name"]}",
                      style:TextStyle(
                        color: Colors.red,
                        )
                      ),
                      children: <Widget>[
                      columnMake(data, index)
                    ],
                  ),
                ),
              );
          


                 
            
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children:[
              buildDropdown(context),
              Expanded(
                  child:SizedBox(
                    height:800.0,
                    child:Scrollbar(
                    child:ListView.separated(
                      padding:EdgeInsets.all(20),
                      separatorBuilder: (context, index) => SizedBox(height:12),
                      itemCount:items,
                      itemBuilder: (context, index) => buildCard(index+1),
                      
                    )
                    )
                  )
              )
            


              ]));
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

      },
    );
  }
  


}