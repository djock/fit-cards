import 'package:fitcards/utilities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralModal extends StatelessWidget {
  final String title;
  final String subTitle;

  final String okActionText;
  final String cancelActionText;

  final Function okAction;
  final Function cancelAction;

  const GeneralModal(
      {Key key,
      this.title,
      this.subTitle,
      this.okAction,
      this.cancelAction,
      this.okActionText,
      this.cancelActionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            color: Theme.of(Get.context).textTheme.bodyText1.color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0),
              title != null && title.isNotEmpty
                  ? Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(height: 16.0),
              Text(
                subTitle,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(Get.context).primaryColorDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.0),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      cancelAction();
                    },
                    child: Text(
                      AppLocalizations.cancel,
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      okAction();
                    },
                    child: Text(
                      AppLocalizations.continueText,
                      style: TextStyle(
                          color: Theme.of(Get.context).primaryColorDark,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
