import 'package:flutter/material.dart';
import 'package:flutter_demo/stateManage/provider/first_screen.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter_demo/stateManage/scopedModel/CountModel.dart';
import 'package:flutter_demo/stateManage/scopedModel/topScreen.dart';
import 'package:flutter_demo/stateManage/redux/topScreenRedux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_demo/stateManage/redux/countState.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GridHomePage extends StatefulWidget {
  final store =
  Store<CountState>(reducer, initialState: CountState.initState());

  @override
  State<StatefulWidget> createState() => _GridHomePageState();
}

class _GridHomePageState extends State<GridHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('网格之家'),
        ),
        body:FirstScreen(),
      );
  }

//  //创建顶层状态
//  CountModel countModel = CountModel();
//
//  @override
//  Widget build(BuildContext context) {
//    return ScopedModel<CountModel>(
//      model: countModel,
//      child: new MaterialApp(
//        title: 'Flutter Demo',
//        theme: new ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        home: TopScreen(),
//      ),
//    );
//  }

//  final Store<CountState> store;
//
//  _GridHomePageState(this.store);
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreProvider<CountState>(
//      store: store,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('Flutter Demo'),
//        ),
//        body:TopScreenRedux(),
//      ),
//    );
//  }
}

