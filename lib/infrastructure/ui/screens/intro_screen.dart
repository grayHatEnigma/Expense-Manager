//flutter core
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  final duration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, '/home'));
    controller = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'الفلوس راحت فين ؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FadeTransition(
                child: Image.asset('images/intro.png'),
                opacity: animation,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 200,
                child: FAProgressBar(
                  direction: Axis.horizontal,
                  size: 20,
                  animatedDuration: duration,
                  backgroundColor: Theme.of(context).accentColor,
                  progressColor: Theme.of(context).primaryColor,
                  currentValue: 100,
                  displayText: '%',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
