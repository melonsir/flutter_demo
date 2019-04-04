import 'package:flutter/material.dart';
import 'package:flutter_demo/util/ThemeUtils.dart';
import 'package:flutter_demo/util/DataUtils.dart';
import 'package:flutter_demo/constants/Constants.dart';
import 'package:flutter_demo/events/ChangeThemeEvent.dart';

class WorkLogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkLogPageState();
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text('text'),
      onTap: () => debugPrint('clicked'),
    );
  }
}

class _WorkLogPageState extends State<WorkLogPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    Constants.eventBus.fire(new ChangeThemeEvent(c));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('工作日志'),
          elevation: 5.0, // 阴影
          actions: <Widget>[Container()],
          flexibleSpace: Container(
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.local_florist)),
            ],
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black38,
          ),
        ),
        //body: new Center(
        //  child: null,
        //),
        body: TabBarView(controller: _tabController, children: [
          Icon(
            Icons.home,
            color: Theme.of(context).primaryColor,
          ),
          Scaffold(
              appBar: new AppBar(
                title: new Text('切换主题', style: new TextStyle(color: Colors.white)),
                iconTheme: new IconThemeData(color: Colors.white),
              ),
              body: new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new GridView.count(
                    crossAxisCount: 6,
                    children: new List.generate(colors.length, (index) {
                      return new InkWell(
                        onTap: () {
                          ThemeUtils.currentColorTheme = colors[index];
                          DataUtils.setColorTheme(index);
                          changeColorTheme(colors[index]);
                        },
                        child: new Container(
                          color: colors[index],
                          margin: const EdgeInsets.all(3.0),
                        ),
                      );
                    }),
                  ))),
        ]));
  }
}
