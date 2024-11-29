import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  warning,
  success,
  error,
}

Color getColorFromState(ToastStates state) {
  switch (state) {
    case ToastStates.warning:
      {
        return Colors.amber;
      }
    case ToastStates.error:
      {
        return Colors.red;
      }
    case ToastStates.success:
      {
        return Colors.green;
      }
  }
}

void showToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getColorFromState(state),
      textColor: Colors.white,
      fontSize: 14.0);
}

Future goToPage({required Widget page, required BuildContext context}) async {
  return Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page,
  ));
}

Future goToPageAndFinish(
    {required Widget page, required BuildContext context}) async {
  return Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => page,
  ));
}
