import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutEndScreen extends StatefulWidget {
  const WorkoutEndScreen({
    Key key,
  }) : super(key: key);

  @override
  _WorkoutEndScreenState createState() => _WorkoutEndScreenState();
}

class _WorkoutEndScreenState extends State<WorkoutEndScreen> {
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Path _drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Future<Null> _startCountdown() async {
    const timeOut = const Duration(milliseconds: 500);
    new Timer(timeOut, () {
      setState(() {
        _confettiController.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: null,
      body: Stack(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.workoutFinished,
                        textAlign: TextAlign.center,
                        style: AppTheme.textAccentBold30(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.tapToClose,
                        textAlign: TextAlign.center,
                        style: AppTheme.textAccentBold15(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              // don't specify a direction, blast randomly
              shouldLoop: true,
              // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              // manually specify the colors to be used
              createParticlePath: _drawStar, // define a custom shape/path.
            ),
          ),
        ],
      ),
    );
  }
}
