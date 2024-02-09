import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/reordable_list_item.dart';
import 'package:flutter/material.dart';

class ExercisesListModal extends StatefulWidget {
  final WorkoutController workoutController;
  final Function callback;

  const ExercisesListModal(
      {Key? key, required this.workoutController, required this.callback})
      : super(key: key);

  @override
  _ExercisesListModalState createState() => _ExercisesListModalState();
}

class _ExercisesListModalState extends State<ExercisesListModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inactiveButtonGrey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
//        _buildHeader(),
          _buildList(),
        ],
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            children: [
//              _buildHeader(),
              _buildList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    widget.workoutController.exercises
        .removeWhere((element) => element.name == AppLocalizations.exercise);

    return Expanded(
      child: ReorderableListView(
        children: <Widget>[
          for (int index = 0;
              index < widget.workoutController.settings.rounds;
              index++)
            ReorderableListItem(
              key: Key('${widget.workoutController.exercises[index].name}'),
              leftValue: (index + 1).toString(),
              centerValue: '${widget.workoutController.exercises[index].name}',
              rightValue: '═',
              onTap: () {},
              deleteAction: () {},
              shareAction: () {},
              backgroundColor: Colors.red,
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var movedExercise =
                widget.workoutController.exercises.removeAt(oldIndex);
            widget.workoutController.exercises.insert(newIndex, movedExercise);

            if (widget.callback != null) widget.callback();
          });
        },
      ),
    );
  }

//  Widget _buildHeader() {
//    return Stack(
//      children: <Widget>[
//        Container(
//          decoration: BoxDecoration(
//            border: Border(bottom: BorderSide(color: Colors.grey)),
//          ),
//          height: 70,
//          width: MediaQuery.of(context).size.width,
//          child: Align(
//            alignment: Alignment.center,
//            child: Text(
//              AppLocalizations.exercisesOrder,
//              style: TextStyle(
//                  color: Theme.of(Get.context!).primaryColor,
//                  fontFamily: 'Lora',
//                  fontSize: 22,
//                  decoration: TextDecoration.none,
//                  fontWeight: FontWeight.normal),
//            ),
//          ),
//        ),
//        Positioned(
//          child: Container(
//            color: Colors.white,
//            child: InkWell(
//              onTap: () {
//                widget.callback();
//                Get.back();
//              },
//              child: Icon(
//                Icons.close,
//                size: 25,
//                color: Colors.black,
//              ),
//            ),
//          ),
//          right: 22,
//          top: 22,
//        ),
//      ],
//    );
//  }
}
