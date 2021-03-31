import 'dart:math';

import 'package:fitcards/models/base_model.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/screens/cards_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum cardType { exercise, scheme }

typedef void BaseModelCallBack(BaseModel val);

class FitCard extends StatelessWidget {
  final List<BaseModel> list;
  final Color color;
  final CardController cardController;
  final bool isBlocked;
  final cardType type;
  final Function callback;

  const FitCard({
    Key key,
    this.list,
    this.color,
    this.cardController,
    this.isBlocked,
    this.type,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TinderSwapCard(
      isBlocked: isBlocked,
      swipeUp: true,
      swipeDown: true,
      orientation: AmassOrientation.RIGHT,
      totalNum: list.length,
      stackNum: 3,
      animDuration: 300,
      swipeEdge: 7.0,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      maxHeight: MediaQuery.of(context).size.width * 0.9,
      minWidth: MediaQuery.of(context).size.width * 0.8,
      minHeight: MediaQuery.of(context).size.width * 0.8,
      cardBuilder: (context, index) {
        if (index == list.length - 1) {
          return _buildRefreshCard(color);
        }
        cardController.setIndex(index);

        int colorIndex = 0;

        if (index > AppColors.exerciseCardColors.length - 1) {
          colorIndex = index % AppColors.exerciseCardColors.length;
        } else {
          colorIndex = index;
        }

        if (type == cardType.exercise) {
          var exerciseModel = list[index] as ExerciseModel;
          return _buildCard(
              exerciseModel.name, AppColors.exerciseCardColors[colorIndex],
              points: exerciseModel.points,
              isFirstCard: list[index].name == AppLocalizations.exercise);
        } else {
          return _buildCard(
              list[index].name, AppColors.schemeCardColors[colorIndex],
              isFirstCard: list[index].name == AppLocalizations.scheme);
        }
      },
      cardController: cardController,
      swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
        /// Get swiping card's alignment
        if (align.x < 0) {
        } else if (align.x > 0) {}
      },
      swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        /// Get orientation & index of swiped card!
        if (orientation == CardSwipeOrientation.LEFT ||
            orientation == CardSwipeOrientation.RIGHT) {
          callback();
        }
      },
    );
  }

  Widget _buildCard(String text, Color color,
      {int points = 0, bool isFirstCard = false}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 0.7,
          )),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: type == cardType.exercise
                    ? _buildExeciseCardText(text, isFirstCard)
                    : _buildSchemeCardText(text, isFirstCard),
              ),
            ),
          ),
          _buildExerciseCardPointsText(points),
          isFirstCard ? _buildFirstCardIcon(points) : SizedBox()
        ],
      ),
    );
  }

  Widget _buildRefreshCard(Color color) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: color,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.refresh,
            style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExeciseCardText(String text, bool isFirstCard) {
    List<Widget> result = [];

    if (isFirstCard) {
      result.add(Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.swipeToStart,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: AppColors.canvasColorLight.withOpacity(1)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));

      return result;
    }

    result.add(Text(
      '$text',
      style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.normal,
          color: AppColors.canvasColorLight),
      textAlign: TextAlign.center,
    ));

    return result;
  }

  List<Widget> _buildSchemeCardText(String text, bool isFirstCard) {
    List<Widget> result = [];

    if (isFirstCard) {
      result.add(SizedBox());
      return result;
    }

    var textArray = text.split(' ');

    result.add(Text(
      '${textArray[0]}',
      style: TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.normal,
          color: AppColors.canvasColorLight),
      textAlign: TextAlign.center,
    ));

    result.add(Text(
      '${textArray[1]}',
      style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.normal,
          color: AppColors.canvasColorLight),
      textAlign: TextAlign.center,
    ));

    return result;
  }

  Widget _buildExerciseCardPointsText(int points) {
    if (type == cardType.exercise && !(points == 0)) {
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '+$points',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: AppColors.canvasColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SizedBox();
  }

  Widget _buildFirstCardIcon(int points) {
    if (points == 0) {
      return Align(
        alignment: Alignment.center,
        child: Icon(
          type == cardType.exercise
              ? FontAwesomeIcons.running
              : FontAwesomeIcons.bullseye,
          size: 140,
          color: AppColors.canvasColorLight.withOpacity(0.2),
        ),
      );
    }

    return SizedBox();
  }
}
