import 'package:flutter/material.dart';

void showAlertDialogWithRoute(
  BuildContext context,
  String title,
  String message,
  String buttonText,
  String route,
) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonText),
    onPressed: () {
      Navigator.of(context).pushNamed(route);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialog(
  BuildContext context,
  String title,
  String message,
  String buttonText,
) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonText),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
