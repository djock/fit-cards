import 'package:fitcards/models/base_model.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:flutter/material.dart';

enum cardType {
  exercise,
  scheme
}

typedef void BaseModelCallBack(BaseModel val);

class FitCard extends StatelessWidget {
  final List<BaseModel> list;
  final Color color;
  final CardController cardController;
  final bool isBlocked;
  final cardType type;

  const FitCard({Key key, this.list, this.color, this.cardController, this.isBlocked, this.type, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TinderSwapCard(
      isBlocked: true,
      swipeUp: true,
      swipeDown: true,
      orientation: AmassOrientation.RIGHT,
      totalNum: list.length,
      stackNum: 3,
      animDuration: 300,
      swipeEdge: 5.0,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      maxHeight: MediaQuery.of(context).size.width * 0.9,
      minWidth: MediaQuery.of(context).size.width * 0.8,
      minHeight: MediaQuery.of(context).size.width * 0.8,
      cardBuilder: (context, index) {
        if(index == list.length - 1) {
          return _buildRefreshCard(color);
        }
        cardController.setIndex(index);

        if(type == cardType.exercise) {
          var exerciseModel = list[index] as ExerciseModel;
          return _buildCard(exerciseModel.name, color, points: exerciseModel.points);
        } else {
          return _buildCard(list[index].name, color);
        }
      },
      cardController: cardController,
      swipeUpdateCallback:
          (DragUpdateDetails details, Alignment align) {
        /// Get swiping card's alignment
        if (align.x < 0) {
        } else if (align.x > 0) {}
      },
      swipeCompleteCallback:
          (CardSwipeOrientation orientation, int index) {
        /// Get orientation & index of swiped card!
        if (orientation == CardSwipeOrientation.LEFT) {
        } else if (orientation == CardSwipeOrientation.RIGHT) {
        }
      },
    );
  }

  Widget _buildCard(String text, Color color, {int points = 0}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 0.7,
          )
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.normal,
                    color: AppColors.mainColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          type == cardType.exercise && points != 0 ? Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '+$points',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: AppColors.mainColor),
                textAlign: TextAlign.center,
              ),
            ),
          ) : SizedBox(height: 0,)
        ],
      ),
    );
  }

  Widget _buildRefreshCard(Color color) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
//          side: BorderSide(
//            color: Colors.black,
//            width: 0.7,
//          )
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'REFRESH',
          style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}