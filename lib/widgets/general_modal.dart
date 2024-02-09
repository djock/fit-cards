import 'package:fitcards/handlers/app_theme.dart';
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
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.okAction,
      required this.cancelAction,
      required this.okActionText,
      required this.cancelActionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: new BoxDecoration(
            color: AppTheme.widgetBackground(),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
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
              title.isNotEmpty
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
                style:
                    TextStyle(fontSize: 16.0, color: AppTheme.dynamicColor()),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.0),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      cancelAction();
                    },
                    child: Text(
                      AppLocalizations.cancel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      okAction();
                    },
                    child: Text(
                      AppLocalizations.continueText,
                      style: TextStyle(
                          color: Theme.of(Get.context!).primaryColor,
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
