import 'package:fitcards/utilities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HowItWorksOverlay {
  static void build(List<String> texts) {
    showGeneralDialog(
        context: Get.context!,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SafeArea(
            top: false,
            child: Builder(builder: (context) {
              return Scaffold(
                backgroundColor: Colors.black.withOpacity(0.5),
                body: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildTexts(texts),
                    )),
                  ),
                ),
              );
            }),
          );
        },
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 150));
  }

  static List<Widget> _buildTexts(List<String> texts) {
    List<Widget> result = [];

    result.add(Text(
      AppLocalizations.howItWorks,
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
      ),
    ));

    result.add(SizedBox(
      height: 40,
    ));

    for (var item in texts) {
      result.add(Text(
        item,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ));

      result.add(SizedBox(
        height: 15,
      ));
    }

    result.add(SizedBox(
      height: 40,
    ));

    result.add(Text(
      AppLocalizations.tapToClose,
      style: TextStyle(
          color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic),
    ));

    return result;
  }
}
