import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/json_data_handler.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen>
    with TickerProviderStateMixin {
  ExerciseModel _exercise = JsonDataHandler.exercises[0];
  SchemeModel _scheme = JsonDataHandler.schemes[0];

  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  bool hasStarted = false;

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: CustomAppBar.buildEmpty(context),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            height: MediaQuery.of(context).size.height * 0.91,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: FitCard(
                      list: JsonDataHandler.exercises,
                      color: Colors.white,
                      cardController: _exerciseController,
                      isInteractive: hasStarted,),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 4,
                  child: FitCard(
                      list: JsonDataHandler.schemes,
                      color: Colors.white,
                      cardController: _schemeController,
                      isInteractive: hasStarted,),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
//                  _buildNextButton(),
                      _buildStartButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
          hasStarted ? Align(
              alignment: Alignment.topCenter,
              child: CardsTimer()) : SizedBox(height: 0,),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return CustomButton(
      buttonColor: AppColors.mandarin,
      onPressed: () {
//        var exerciseRandom = new Random();
//        if (exerciseRandom.nextBool()) {
//          _exerciseController.triggerLeft();
//          _schemeController.triggerLeft();
//        } else {
//          _exerciseController.triggerRight();
//          _schemeController.triggerRight();
//        }
      },
      textColor: AppColors.mainGrey,
      isOutline: false,
      isRequest: false,
      buttonText: 'Next',
    );
  }

  Widget _buildStartButton() {
    return CustomButton(
      buttonColor: AppColors.mandarin,
      onPressed: () {
        setState(() {
          hasStarted = !hasStarted;
        });
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => TrainScreen(
//                      exerciseIndex: _exerciseController.index,
//                      schemeIndex: _schemeController.index,
//                    ))
//        );
      },
      textColor: AppColors.mainGrey,
      isOutline: false,
      isRequest: false,
      buttonText: hasStarted ? 'Stop' : 'Start',
    );
  }
}
