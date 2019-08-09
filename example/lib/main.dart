import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sim_check/flutter_sim_check.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String simExist = 'Unknown';
  String can = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: <Widget>[
              FlatButton(
                  onPressed: () => _checkIsSimulator(), child: Text('开始检测')),
              Text("simExist：" + simExist),
              Text("isSimulator：" + can)
            ],
          )),
    );
  }

  Future<void> _checkIsSimulator() async {
    bool can1 = await FlutterSimCheck.checkSimExist;
    bool can2 = await FlutterSimCheck.checkIsSimulator;
    setState(() {
      simExist = can1.toString();
      can = can2.toString();
    });
  }
}
