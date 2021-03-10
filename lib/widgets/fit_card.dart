import 'package:fitcards/models/base_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:flutter/material.dart';

typedef void BaseModelCallBack(BaseModel val);

class FitCard extends StatelessWidget {
  final List<BaseModel> list;
  final Color color;
  final CardController cardController;
  final bool isInteractive;

  const FitCard({Key key, this.list, this.color, this.cardController, this.isInteractive, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TinderSwapCard(
      isInteractive: isInteractive,
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
        return _buildCard(list[index].name, color);
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

  Widget _buildCard(String text, Color color) {
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
      child: Align(
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