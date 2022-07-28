import 'package:flutter/material.dart';

class Error {
  static void showErrorDialog(String errorMsg, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(errorMsg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('An error Ocuured!'),
    //     content: Text(errorMsg),
    //     actions: <Widget>[
    //       ElevatedButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: Text('okay'),
    // ),
    // ],
    // ),
    // );
  }
}
