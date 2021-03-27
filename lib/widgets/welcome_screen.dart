import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/screens/home_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() =>
      _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  Widget _entryField(String defaultText) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _textController,
              keyboardType: TextInputType.name,
              validator: (value) {
                bool fieldValid = false;
                fieldValid = value.length > 0;

                if (!fieldValid) {
                  return AppLocalizations.errorNoName;
                }
                return null;
              },
              obscureText: false,
              decoration: CustomInputDecoration.build(defaultText),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField(AppLocalizations.username),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return _buildScreen();
  }

  Widget _buildScreen() {
    return Container(
      color: Colors.red,
      child: SafeArea(
        top: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              color: AppColors.mandarin.withOpacity(0.9),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 180),
                  Text(
                    AppLocalizations.chooseName,
                    style: TextStyle(fontFamily: 'Lora', fontSize: 28, color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _formWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonColor: Colors.white,
                    textColor: Colors.red,
                    isOutline: false,
                    buttonText: AppLocalizations.start,
                    onPressed: () {
                    if (_formKey.currentState.validate()) {
                      UserPreferencesHandler.saveUserName(_textController.text);

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}