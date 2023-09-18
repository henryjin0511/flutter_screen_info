import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:voltron_screen_info/base_screen_info.dart';
import 'package:voltron_screen_info/voltron_screen_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BaseScreenInfo _screenInfo = BaseScreenInfo({});

  @override
  void initState() {
    super.initState();
    initScreenInfo();
  }

  Future<void> initScreenInfo() async {
    var voltronScreenInfoPlugin = VoltronScreenInfoPlugin();
    BaseScreenInfo? screenInfo;
    if (Platform.isAndroid) {
      screenInfo = await voltronScreenInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      screenInfo = await voltronScreenInfoPlugin.iosInfo;
    }

    if (!mounted) return;
    setState(() {
      if (screenInfo == null) return;
      _screenInfo = screenInfo;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VoltronScreenInfo example'),
          elevation: 4,
        ),
        body: ListView(
          children: <Widget>[
            _infoTile('ScreenInfo', _screenInfo.toString()),
          ],
        ),
      ),
    );
  }
}
