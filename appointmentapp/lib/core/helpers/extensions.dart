import 'package:flutter/material.dart';

extension MediaQueryHelper on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}

extension NavigatorHelper on BuildContext {
  Future pushReplacementNamed(
    String routeName, {
    Object? result,
    Object? arguments,
  }) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  Future pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future pushNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}
