import 'package:flutter/material.dart';

class Error {
  static void showErrorDialog(String errorMsg, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(errorMsg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
