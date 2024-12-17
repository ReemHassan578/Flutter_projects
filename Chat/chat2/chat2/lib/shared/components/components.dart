import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/icon_broken.dart';

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
      fontSize: 14.0.sp);
}

Future goToPage({required Widget page, required BuildContext context}) async {
  return Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page,
  ));
}

Future goToPageAndFinish(
    {required Widget page, required BuildContext context}) async {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => false,
  );
}

AppBar buildDefaultAppBar({
  String? title,
  required BuildContext context,
  List<Widget> actions = const [],
}) {
  return AppBar(
    title: Text(title ?? ''),
    titleSpacing: 5.w,
    actions: actions,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(IconBroken.Arrow___Left_2)),
  );
}
