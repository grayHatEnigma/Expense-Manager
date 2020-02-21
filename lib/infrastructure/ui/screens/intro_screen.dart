import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../../constants.dart';
import '../../../domain/managers/plan_manager.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  final duration = Duration(milliseconds: 4000);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final planManager = Provider.of<PlanManager>(context);

    // check if the user has a saved plan or not
    planManager.hasPlan.then((hasSavedPlan) {
      Future.delayed(
        Duration(milliseconds: 4500),
        () => Navigator.pushReplacementNamed(
            context, hasSavedPlan ? kHomeScreenID : kPlanSalaryScreenID),
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                kTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: RotationTransition(
                child: Image.asset(
                  'images/wallet.png',
                  height: 160,
                  width: 160,
                ),
                turns: animation,
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
                  backgroundColor: Theme.of(context).primaryColorDark,
                  progressColor: Theme.of(context).accentColor,
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

  @override
  void dispose() {
    // dispose the animation controller to avoid memory leaks.
    controller.dispose();
    super.dispose();
  }
}
