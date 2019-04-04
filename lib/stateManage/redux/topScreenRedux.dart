import 'package:flutter/material.dart';
import 'package:flutter_demo/stateManage/redux/underScreenRedux.dart';
import 'package:flutter_demo/stateManage/redux/countState.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TopScreenRedux extends StatefulWidget {
  @override
  _TopScreenReduxState createState() => _TopScreenReduxState();
}

class _TopScreenReduxState extends State<TopScreenRedux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      body: Center(
        child: StoreConnector<CountState,int>(
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return UnderScreenRedux();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}