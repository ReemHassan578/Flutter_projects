import 'package:flutter/material.dart';

class MyColor extends InheritedWidget {
  final Color color;
  const MyColor({super.key, required this.color, required super.child});
  //: super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant MyColor oldWidget) {
    return oldWidget.color != color;
  }

  static MyColor of(context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>();
  }
}
