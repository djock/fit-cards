import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  String _loadingText = '';

  @override
  void initState() {
    _loadingText = Utils.getLoadingScreenText();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: false);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: AppColors.canvasColorDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_loadingText,
                    style: AppTheme.customAccentText(FontWeight.normal, 18)),
              ),
              LinearProgressIndicator(
                value: _controller.value,
                backgroundColor: AppColors.canvasColorDark,
                semanticsLabel: 'Linear progress indicator',
              )
            ],
          ),
        ),
      ),
    );
  }
}
