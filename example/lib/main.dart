import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamp/lamp.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasFlash = false;
  bool _isOn = false;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool hasFlash;

    hasFlash = await Lamp.hasFlash;
    print("Device has flash ? $hasFlash");

    if (!mounted)
      return;

    setState(() { _hasFlash = hasFlash; });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Device has flash: $_hasFlash\n Flash is on: $_isOn'),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.flash_off),
          onPressed: turnFlash),
      ),
    );
  }

  void turnFlash() {
    Lamp.turn(!_isOn);
    setState((){
      _isOn = !_isOn;
    });
  }
}