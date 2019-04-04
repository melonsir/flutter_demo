import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infinite_cards/infinite_cards.dart';

class ServePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServePageState();
}

class _ServePageState extends State<ServePage> {
  InfiniteCardsController _controller;
  bool _isTypeSwitch = true;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteCardsController(
      itemBuilder: _renderItem,
      itemCount: 5,
      animType: AnimType.SWITCH,
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    return Image(
      image: AssetImage('images/pic${index + 1}.png'),
    );
  }

  void _changeType(BuildContext context) {
    if (_isTypeSwitch) {
      _controller.reset(
        itemCount: 4,
        animType: AnimType.TO_FRONT,
        transformToBack: _customToBackTransform,
      );
    } else {
      _controller.reset(
        itemCount: 5,
        animType: AnimType.SWITCH,
        transformToBack: DefaultToBackTransform,
      );
    }
    _isTypeSwitch = !_isTypeSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InfiniteCards"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InfiniteCards(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 1.3,
              controller: _controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _controller.reset(
                          animType: _isTypeSwitch ? AnimType.SWITCH : AnimType.TO_FRONT);
                      _controller.previous();
                    },
                    child: Text("Pre"),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _changeType(context);
                    },
                    child: Text("Reset"),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _controller.reset(animType: AnimType.TO_END);
                      _controller.next();
                    },
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Transform _customToBackTransform(Widget item, double fraction, double curveFraction,
    double cardHeight, double cardWidth, int fromPosition, int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double rotateY;
  double translationX;
  if (fraction < 0.5) {
    translationX = cardWidth * fraction * 1.5;
    rotateY = math.pi / 2 * fraction;
  } else {
    translationX = cardWidth * 1.5 * (1 - fraction);
    rotateY = math.pi / 2 * (1 - fraction);
  }
  double interpolatorScale = 0.8 - 0.1 * fromPosition + (0.1 * curveFraction * positionCount);
  double translationY = -cardHeight * (0.8 - interpolatorScale) * 0.5 -
      cardHeight * (0.02 * fromPosition - 0.02 * curveFraction * positionCount);
  return Transform.translate(
    offset: Offset(translationX, translationY),
    child: Transform.scale(
      scale: scale,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(rotateY),
        alignment: Alignment.center,
        child: item,
      ),
    ),
  );
}
