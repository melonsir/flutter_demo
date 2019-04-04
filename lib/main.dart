import 'package:flutter/material.dart';
import 'package:flutter_demo/index/index.dart';
import 'package:sqljocky5/sqljocky.dart';
import 'package:flutter_demo/gridHome/gridHome_page.dart';
import 'package:flutter_demo/home/home_page.dart';
import 'package:flutter_demo/redSleeve/redSleeve_page.dart';
import 'package:flutter_demo/workLog/workLog_page.dart';
import 'package:flutter_demo/serve/serve_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter_demo/stateManage/provider/counter.dart';
import 'package:flutter_demo/stateManage/provider/switcher.dart';
import 'package:flutter_demo/constants/Constants.dart';
import 'package:flutter_demo/events/ChangeThemeEvent.dart';
import 'package:flutter_demo/util/ThemeUtils.dart';
import 'package:flutter_demo/util/DataUtils.dart';

// 入口函数
void main() {
  var counter = Counter();
  var switcher = Switcher();

  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<Switcher>.value(switcher));

  runApp(
    ProviderNode( child: MyApp(), providers: providers, ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtils.supportColors[1];

  @override
  void initState() {
    super.initState();
    DataUtils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        Constants.eventBus.fire(new ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: new Index(),
    );
  }
}