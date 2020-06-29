import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';
import 'dart:core';

import 'package:light/light.dart';


class LightWidget extends StatefulWidget {
  @override
  _LightWidgetState createState() => new _LightWidgetState();
}

class _LightWidgetState extends State<LightWidget> {
  String _luxString = 'Unknown';
  Light _light;
  StreamSubscription _subscription;
  DateTime startTime;
  Duration duration=Duration(hours: 0,minutes: 0,seconds: 0);
  Duration selectedTime=Duration(hours: 0,minutes: 0,seconds: 5);
  AudioCache audioCache = AudioCache();
  AudioPlayer player;

  void showColoredToast(var tm) {
    Fluttertoast.showToast(
        msg: 'Selected Alarm Time is $tm minutes',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }


  void setTimer(int minutes){
    this.selectedTime=Duration(minutes: minutes);
    print(selectedTime);
    showColoredToast(minutes);

    //startListening();
  }

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
      duration = DateTime.now().difference(startTime);
      print(this.selectedTime);
    });

    if(duration.compareTo(selectedTime)>=1) {
      stopListening();
      //audioCache.loop("alarm.mp3");
      if(luxValue!=0)
      player=await playLocalAsset();


    }
  }



  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    return await cache.loop("alarm.mp3");
  }

  void stopListening() {
    _subscription.cancel();
    setState(() {
      _luxString = "0";
      duration=Duration(hours: 0,minutes: 0,seconds: 0);
      selectedTime=Duration(hours: 0,minutes: 0,seconds: 5);
      print(selectedTime);
      //audioCache.clear("alarm.mp3");
    });
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    }
    on LightException catch (exception) {
      print(exception);
    }
  }



  @override
  void initState() {
    super.initState();
    initPlatformState();
    startTime=DateTime.now();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextCard("Light Intensity"),
          LightValueCard(_luxString),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              StartWidget((){
                this.startListening();
                this.startTime=DateTime.now();
              }),
              ResetWidget(
                      (){
                          this.stopListening();
                          if(player!=null)
                            player.stop();
                      }
                ),
            ],
          ),
          TextCard(duration.inHours.toString()+":"+duration.inMinutes.toString()+":"+duration.inSeconds.toString()),
          DurationCard(
              setTimer
          ),
        ],

      ),
    );
  }
}

class TextCard extends StatelessWidget {
  final msg;
  TextCard(this.msg);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
      child: ListTile(
        title: Text("$msg",textAlign: TextAlign.center,),
      ),
    );
  }
}

class LightValueCard extends StatelessWidget {
  final String lightInfo;

  LightValueCard(this.lightInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
      child: ListTile(
        title: Text("$lightInfo",textAlign: TextAlign.center,),
      ),
    );
  }
}

class ResetWidget extends StatelessWidget {

  final Function onPressFunc;
  ResetWidget(this.onPressFunc);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
        child: FlatButton(
          //onPressed: this.onPressFunc,
          child: Text("Reset/Stop Alarm"),
          onPressed: this.onPressFunc,
        ),
      ),
    );
  }
}

class StartWidget extends StatelessWidget {

  final Function onPressFunc;
  StartWidget(this.onPressFunc);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
        child: FlatButton(
          //onPressed: this.onPressFunc,
          child: Text("Start"),
          onPressed: this.onPressFunc,
        ),
      ),
    );
  }
}

class DurationCard extends StatelessWidget {
  final Function onPressFunc;
  DurationCard(this.onPressFunc);
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          maxRadius: 35.0,
          child: FlatButton(
            child: Text("1 Min",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
            onPressed: (){
              onPressFunc(1);
              //showColoredToast(1);
            },
          ),
          backgroundColor: Colors.white,

        ),
        CircleAvatar(
          maxRadius: 35.0,
          child: FlatButton(
            child: Text("15 Min",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
              onPressed: (){
                onPressFunc(15);
              },
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          maxRadius: 35.0,
          child: FlatButton(
            child: Text("30 Min",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
              onPressed: (){
                onPressFunc(30);
              },
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          maxRadius: 35.0,
          child: FlatButton(
            child: Text("60 Min",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
              onPressed: (){
                onPressFunc(60);
              },
          ),
          backgroundColor: Colors.white,
        ),
      ],
    );;
  }
}