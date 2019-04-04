import 'package:flutter/material.dart';
import 'package:flutter_demo/gridHome/gridHome_page.dart';
import 'package:flutter_demo/redSleeve/redSleeve_page.dart';
import 'package:flutter_demo/workLog/workLog_page.dart';
import 'package:flutter_demo/serve/serve_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
  final color = Theme.of(context).primaryColor;

  return Column(
    // main axis 跟我们前面提到的 cross axis 相对应，对 Column 来说，指的就是竖直方向。
    // 在放置完子控件后，屏幕上可能还会有一些剩余的空间（free space），min 表示尽量少占用
    // free space；类似于 Android 的 wrap_content。
    // 对应的，还有 MainAxisSize.max
    mainAxisSize: MainAxisSize.min,
    // 沿着 main axis 居中放置
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      )
    ],
  );
}

class _HomePageState extends State<HomePage> {
  final snackBar = SnackBar(content: Text('这是一个SnackBar!'));
  @override
  Widget build(BuildContext context) {
    final buttonSection = Container(
      child: Row(
        // 沿水平方向平均放置
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(context, Icons.call, 'CALL'),
          _buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
    final titleSection = _TitleSection('Oeschinen Lake Campground', 'Kandersteg, Switzerland', 41);
    final textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
        softWrap: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          actions: <Widget>[new Container()],
        ),
        //body: new Center(
        //  child: RouteButton(),
        //  //child: new SnackBarPage(),
        // ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'images/lake.png',
              width: 600.0,
              height: 240.0,
              // cover 类似于 Android 开发中的 centerCrop，其他一些类型，读者可以查看
              // https://docs.flutter.io/flutter/painting/BoxFit-class.html
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              //userHeader , // 可在这里替换自定义的header
              ListTile(
                title: Text('Item 1'),
                leading: CircleAvatar(
                  child: Icon(Icons.school),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                leading: CircleAvatar(
                  child: Text('B2'),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 3'),
                leading: CircleAvatar(
                  child: Icon(Icons.list),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int starCount;

  _TitleSection(this.title, this.subtitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // 为了给 title section 加上 padding，这里我们给内容套一个 Container
    return Container(
      // 设置上下左右的 padding 都是 32。类似的还有 EdgeInsets.only/symmetric 等
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          // 这里为了让标题占满屏幕宽度的剩余空间，用 Expanded 把标题包了起来
          Expanded(
            // 再次提醒读者，Expanded 只能包含一个子元素，使用的参数名是 child。接下来，
            // 为了在竖直方向放两个标题，加入一个 Column。
            child: Column(
              // Column 是竖直方向的，cross 为交叉的意思，也就是说，这里设置的是水平方向
              // 的对齐。在水平方向，我们让文本对齐到 start（读者可以修改为 end 看看效果）
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 聪明的你，这个时候肯定知道为什么突然加入一个 Container 了。
                // 跟前面一样，只是为了设置一个 padding
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),

          // 这里是 Row 的第二个子元素，下面这两个就没用太多值得说的东西了。
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),

          Text(starCount.toString())
        ],
      ),
    );
  }
}

class RouteButton extends StatefulWidget {
  // StatefulWidget 需要实现这个方法，返回一个 State
  @override
  State createState() {
    return _RouteButtonState();
  }
}

// 可能看起来有点恶心，这里的泛型参数居然是 RollingButton
class _RouteButtonState extends State<RouteButton> {
  final snackBar = SnackBar(
    backgroundColor: Color.fromARGB(23, 23, 23, 23),
    content: Text('这是一个SnackBar!'),
    action: SnackBarAction(
        label: '撤消',
        onPressed: () {
          // do something to undo
        }),
  );
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      highlightColor: Color(0xFF82B1FF),
      child: Text('raisedButton'),
      onPressed: _onPressed,
    );
  }

  void _onPressed() {
    //Navigator.of(context).pushNamed('/redSleeve');
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
