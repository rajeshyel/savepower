import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:light/light.dart';

import 'lightdata.dart';

void main(){
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LightWidget(),
              ],
            ),
          ),
        )
    );
  }
}


/*
    CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.red,
                  backgroundImage: AssetImage('images/angela.jpg'),
                ),
                Text(
                  "Angela ...Yu",
                  style:TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ) ,
                ),
                Text(
                  "FLUTTER DEVELOPER",
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 25.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade100,
                  ),
                ),
                SizedBox(height: 20.0,width: 150,child:Divider(color: Colors.teal.shade100,)),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.phone,color: Colors.teal,),
                    title: Text("+44 123 456 789",
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                      ),),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.email,color: Colors.teal,),
                    title: Text("angela@gmail.com",
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                      ),),
                  ),
                )
 */
