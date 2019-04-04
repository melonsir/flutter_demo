import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_demo/stateManage/provider/counter.dart';
import 'package:flutter_demo/stateManage/provider/switcher.dart';
import 'package:flutter_demo/stateManage/provider/first_screen.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondScreen'),
//        leading: IconButton(
//            icon: const Icon(Icons.keyboard_arrow_left),
//            onPressed: () {
//              Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => FirstScreen()));
//             },
//        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Provide<Counter>(
              builder: (context, child, counter) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            Provide<Switcher>(
              builder: (context, child, switcher) {
                return Switch(
                    value: switcher.status,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (newValue) {
                      switcher.changeStatus();
                    });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Icon(
          Icons.add
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
