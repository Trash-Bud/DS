import 'package:flutter/material.dart';
import 'dart:async';

Future showStandardDialog(BuildContext context, String title, String message,
    {String yesMessage = 'Ok', String? noMessage}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(yesMessage),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            if (noMessage != null)
              TextButton(
                child: Text(noMessage),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
          ],
        );
      });
}

